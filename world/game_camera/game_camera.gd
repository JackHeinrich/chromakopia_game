@tool

extends Camera2D

class_name GameCamera

@export var follow_target: Node2D

enum Modes {FOLLOWING, STATIC, DOLLY}

@export var mode: Modes = Modes.FOLLOWING

@export var random_strength : float = 5.0
@export var shake_fade : float = 6.0

var rng = RandomNumberGenerator.new()

var strength = 0.0

func explosion_mode():
	random_strength = 15

func tank_mode():
	random_strength = 7

func apply_shake():
	strength = random_strength

func randomOffset():
	return Vector2(0,rng.randf_range(-strength, strength))

func _process(delta):
	
	if strength > 0:
		strength = lerpf(strength, 0, shake_fade * delta)
		
		offset = randomOffset()
	
	if mode == Modes.FOLLOWING:
		if follow_target:
			global_position = follow_target.global_position
