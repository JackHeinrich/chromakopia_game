extends State

@export var sprite: Sprite2D

@export var piece_right: GPUParticles2D

@export var piece_left: GPUParticles2D

@export var soldier_line: Node2D

@export var smoke: GPUParticles2D

@export var dirt: GPUParticles2D

@export var blast: Sprite2D

@export var singe: GPUParticles2D

@export var big_explosion: GPUParticles2D

@export var big_fire: GPUParticles2D

@export var world_sprite: Sprite2D

func set_sprite(sprite):
	self.world_sprite = sprite 

func on_beat(beat):
	if beat == 210:
		explode()
	
	if beat == 226:
		world_sprite.material = null

var colorful_gradient = preload("res://gradients/colorful_palette.tres")

@export var scene_camera: Camera2D

@export var boom: AudioStreamPlayer

func explode():
	boom.play()
	scene_camera.random_strength = 15
	scene_camera.shake_fade = 3.0
	scene_camera.apply_shake()
	sprite.hide()
	piece_left.emitting = true
	piece_right.emitting = true
	soldier_line.queue_free()
	dirt.emitting = true
	smoke.emitting = true
	blast.show()
	singe.emitting = true
	big_explosion.emitting = true
	big_fire.emitting = true
	world_sprite.material.set_shader_parameter("gradient", colorful_gradient)
	
