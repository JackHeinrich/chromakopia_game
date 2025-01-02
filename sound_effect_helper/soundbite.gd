extends AudioStreamPlayer

class_name SoundBite

func _ready():
	play()
	await finished
	queue_free()

static func new_soundbite(new_stream, volume, min_pitch_shift = 0, max_pitch_shift = 0):
	var soundbite_scene = preload("res://sound_effect_helper/soundbite.tscn")
	var new_soundbite = soundbite_scene.instantiate()
	
	new_soundbite.pitch_scale = 1 + randf_range(min_pitch_shift, max_pitch_shift)
	
	new_soundbite.volume_db = volume
	new_soundbite.stream = new_stream
	return new_soundbite
