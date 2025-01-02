extends AudioStreamPlayer

@export var bpm = 151.0

@export var measures = 4

var song_position = 0.0
var song_position_in_beats = 1
@onready var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

@export var log_beats = false

var closest = 0
var time_off_beat = 0.0

signal on_beat(position)
signal on_measure(position)

@export var metronome: bool

@export var metronome_player : AudioStreamPlayer

@export var offset = 0

@export var wait_before_start = 0.0

func beats_to_seconds(beats):
	return beats * sec_per_beat

func begin_tutorial():
	reset()
	stream = preload("res://menu_music/tutorial.wav")
	
	if wait_before_start:
		await get_tree().create_timer(wait_before_start).timeout
		play()
	
	elif offset:
		play_from_beat(offset, 0)
	else:
		play()

func reset():
	song_position_in_beats = 0
	song_position_in_half_beats = 0
	closest = 0
	time_off_beat = 0.0
	measure = 1
	song_position = 0.0
	last_reported_beat = 0
	last_reported_half_beat = 0

func begin_chroma():
	reset()
	stream = preload("res://song/8bittopia.wav")
	
	if wait_before_start:
		await get_tree().create_timer(wait_before_start).timeout
		play()
	
	elif offset:
		play_from_beat(offset, 0)
	else:
		play()

func _physics_process(delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		song_position_in_half_beats = int(floor(song_position / (sec_per_beat/2.0))) + (2 * beats_before_start)
		report_beat()
		report_half_beat()

signal on_half_beat(position)

var song_position_in_half_beats = 0
var last_reported_half_beat = 0

func report_half_beat():
	# No need to recalculate `song_position_in_half_beats` here since it is done in `_physics_process`
	if last_reported_half_beat < song_position_in_half_beats:
		on_half_beat.emit(song_position_in_half_beats)

		if log_beats:
			print("Half Beat, ", song_position_in_half_beats)

		last_reported_half_beat = song_position_in_half_beats


func report_beat():
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		on_beat.emit(song_position_in_beats)
		on_measure.emit(measure)
		if log_beats:
			print("Beat, ", song_position_in_beats)
		last_reported_beat = song_position_in_beats
		measure += 1

@export var start_timer : Timer

func play_with_beat_offset(beats):
	beats_before_start = beats
	start_timer.wait_time = sec_per_beat
	start_timer.start()

func closest_beat(nth):
	closest = int(round((song_position / sec_per_beat) / nth) * nth)
	time_off_beat = abs(closest * sec_per_beat - song_position)
	return Vector2(closest, time_off_beat)

func play_from_beat(beat, offset):
	play()
	seek(beat * sec_per_beat)
	beats_before_start = offset
	var i = 1
	while i < beats_before_start:
		measure += 1
		if measure > measures:
			measure = 1
		i += 1

func _on_timer_timeout():
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		start_timer.start()
	elif song_position_in_beats == beats_before_start - 1:
		start_timer.wait_time = start_timer.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
	else:
		play()
		start_timer.stop()
	report_beat()
