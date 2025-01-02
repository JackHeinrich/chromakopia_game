extends Node2D
class_name GamePlayPlane

const plane_scene = preload("res://gameplay_plane/gameplay_plane.tscn")

@export var sprite : Sprite2D

var direction: int

var target_pos : Vector2

var target_y: float

var beats_to_target: int

var beats_to_final: int

@export var collider: Area2D

@export var destroy_particles: GPUParticles2D

@export var shadow: Sprite2D

var explosion_sound = preload("res://gameplay_plane/explosion.wav")

var explosion_volume: float = -7.5

func destroy():
	ScoreKeeper.increment_score()
	SoundEffectHelper.new_sound(explosion_sound,explosion_volume)
	destroy_particles.emitting = true
	sprite.queue_free()
	collider.queue_free()
	var shadow_tween = get_tree().create_tween()
	shadow_tween.tween_property(shadow,"modulate:a", 0.0, GlobalBeatHandler.beats_to_seconds(0.5))
	shadow = null
	x_tween.stop()
	y_tween.stop()

func _process(delta):
	if shadow:
		shadow.global_position.x = global_position.x
		var shadow_scale = 1 + ((target_y - global_position.y)/target_y)
		shadow.scale = Vector2(shadow_scale,shadow_scale)
		shadow.modulate.a = 1.0 + (target_y - global_position.y)/target_y

func _ready():
	if direction == 0:
		sprite.flip_h = true
		destroy_particles.scale.x = -1.0
		shadow.flip_h = true
	shadow.global_position.y = target_y + 96 + randf_range(-4, 4)
	do_tween()

var x_tween
var y_tween

func do_tween():
	var target_tween_pos: Vector2
	var final_tween_pos: Vector2
	if direction == 1:
		global_position += Vector2(-32,-64)
	elif direction == 0:
		global_position += Vector2(32,-64)
	
	if direction == 1:
		target_tween_pos = Vector2(80, target_y)
	elif direction == 0:
		target_tween_pos = Vector2(176, target_y)
	
	var dx = target_tween_pos.x - global_position.x
	
	var dy = global_position.y - target_tween_pos.y
	
	x_tween = get_tree().create_tween()
	y_tween = get_tree().create_tween()
	x_tween.tween_property(self,"global_position:x", global_position.x + (dx * 4), GlobalBeatHandler.beats_to_seconds(beats_to_target * 4))
	y_tween.set_ease(Tween.EASE_OUT)
	y_tween.set_trans(Tween.TRANS_SINE)
	y_tween.tween_property(self,"global_position:y", target_y, GlobalBeatHandler.beats_to_seconds(beats_to_target))
	y_tween.set_ease(Tween.EASE_IN)
	y_tween.tween_property(self,"global_position:y", global_position.y + (dy * 3), GlobalBeatHandler.beats_to_seconds(beats_to_target * 2))

static func new_plane(direction, y_pos, new_beats_to_target):
	var new_plane = plane_scene.instantiate()
	new_plane.global_position.y = y_pos
	
	if direction == 0:
		new_plane.global_position.x = 256
	elif direction == 1:
		new_plane.global_position.x = 0
	
	new_plane.target_y = y_pos
	
	new_plane.beats_to_target = new_beats_to_target
	
	new_plane.direction = direction
	return new_plane
