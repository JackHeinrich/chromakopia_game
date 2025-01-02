extends State

@export var tyler: Node2D
@export var gun_holder: Node2D

@export var gun_holder_holder: Node2D

@export var sprite: Sprite2D

@export var muzzle : Marker2D

var shoot_particle = preload("res://shooting_particles/shooting_particles.tscn")

var shell_particle = preload("res://shell_particles/shell_particles.tscn")

@export var plane_manager : PlaneManager

var pump = false

@export var pump_1: AudioStreamPlayer

@export var pump_2: AudioStreamPlayer

@export var timer : Timer

@export var teleport_spot: Vector2

func _ready():
	timer.wait_time = GlobalBeatHandler.beats_to_seconds(0.5)

@export var leave_beat = 80

var left = false

func on_beat(beat):
	
	if beat == leave_beat:
		transitioned.emit(self,"place_state")
		left = true
	
	if beat >= leave_beat and not left:
		tyler.global_position = teleport_spot
		
		transitioned.emit(self,"smack_state")
	
	if pump and not timer.time_left:
		sprite.frame = 11
		pump = false
		pump_1.play()
	elif sprite.frame == 11 and !pump:
		sprite.frame = 10
		pump_2.play()
		var new_shell = shell_particle.instantiate()
		muzzle.call_deferred("add_child", new_shell)

func update(delta):
	if !plane_manager.ammo:
		return
	
	if Input.is_action_just_pressed("shoot_left") or Input.is_action_just_pressed("shoot_right"):
		var tween = get_tree().create_tween()
		tween.tween_property(gun_holder, "position:y", 4.0, GlobalBeatHandler.beats_to_seconds(0.1))
		tween.parallel().tween_property(sprite, "position:y", -10.0, GlobalBeatHandler.beats_to_seconds(0.1))
		tween.tween_property(gun_holder, "position:y", 0.0, GlobalBeatHandler.beats_to_seconds(0.25))
		tween.parallel().tween_property(sprite, "position:y", -12.0, GlobalBeatHandler.beats_to_seconds(0.5))
		var new_shoot_particle = shoot_particle.instantiate()
		muzzle.call_deferred("add_child", new_shoot_particle)
		pump = true
		timer.start()
		
		
	
	if Input.is_action_just_pressed("shoot_left"):
		gun_holder_holder.scale.x = 1
	elif Input.is_action_just_pressed("shoot_right"):
		gun_holder_holder.scale.x = -1
