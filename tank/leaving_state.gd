extends State

@export var top: Sprite2D

@export var animation_player: AnimationPlayer

@export var smoke_particles: GPUParticles2D

@export var bottom: Sprite2D

@export var clunk1: AudioStreamPlayer

@export var clunk2: AudioStreamPlayer

@export var pup: AudioStreamPlayer

func enter():
	super.enter()
	top.position.y = 5
	animation_player.play("RESET")
	smoke_particles.emitting = false
	pup.queue_free()
	

func on_beat(beat):
	if beat == 180:
		bottom.frame = 2
		clunk1.play()
	if beat == 181:
		bottom.frame = 1
	if beat == 184:
		bottom.frame = 0
		clunk2.play()
