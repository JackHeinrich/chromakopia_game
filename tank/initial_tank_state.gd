extends State

@export var sprite: Sprite2D

@export var close1: AudioStreamPlayer
@export var close2: AudioStreamPlayer

@export var smoke_particles: GPUParticles2D

@export var animator: AnimationPlayer

@export var start: AudioStreamPlayer

@export var tyler: Node2D

var player_locked

@export var tank: Node2D

@export var tween_pos: Vector2

@export var pup: AudioStreamPlayer

func update(delta):
	if player_locked:
		tyler.global_position = tank.global_position + Vector2(0,20)

var track_lock = true

func on_beat(beat):
	if beat == 114:
		sprite.frame = 1
	elif beat == 117:
		sprite.frame = 2
		close1.play()
	elif beat == 118:
		sprite.frame = 0
		close2.play()
		player_locked = true
	elif beat == 120:
		smoke_particles.emitting = true
		animator.play("rumble")
		start.play()
	elif beat == 122:
		var new_tween = get_tree().create_tween()
		track_lock = false
		new_tween.tween_property(tank,"global_position", tween_pos, GlobalBeatHandler.beats_to_seconds(20))
		await new_tween.finished
		transitioned.emit(self,"idle_state")

var frame_offset = 3

func on_half_beat(halfbeat):
	if !track_lock:
		sprite.frame = frame_offset + (halfbeat % 3)
	
	if halfbeat >= 240:
		pup.play()
