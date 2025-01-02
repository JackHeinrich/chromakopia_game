extends State

@export var tank: Node2D
@export var top: Node2D

@export var muzzle : Marker2D

@export var timer: Timer

var shoot_particle = preload("res://shooting_particles/tank_shooting_particles.tscn")

var shell_particle = preload("res://shell_particles/shell_particles.tscn")

var exit_beat = 178

@export var plane_manager : PlaneManager

@export var teleport_spot: Vector2

@export var leave_beat = 200

var left = false

func _ready():
	timer.wait_time = GlobalBeatHandler.beats_to_seconds(0.5)

func on_beat(beat):
	
	if beat >= exit_beat:
		transitioned.emit(self,"leaving_state")
		left = true
	
	if beat >= leave_beat and not left:
		tank.global_position = teleport_spot
		
		transitioned.emit(self,"smack_state")
	
		var new_shell = shell_particle.instantiate()
		muzzle.call_deferred("add_child", new_shell)

func update(delta):
	if !plane_manager.ammo:
		return
	
	if Input.is_action_just_pressed("shoot_left") or Input.is_action_just_pressed("shoot_right"):
		var tween = get_tree().create_tween()
		tween.tween_property(top, "position:y", 12.0, GlobalBeatHandler.beats_to_seconds(0.1))
		tween.tween_property(top, "position:y", 5.0, GlobalBeatHandler.beats_to_seconds(0.4))
		tween.play()
		var new_shoot_particle = shoot_particle.instantiate()
		muzzle.call_deferred("add_child", new_shoot_particle)
		timer.start()
		
	if Input.is_action_just_pressed("shoot_left"):
		top.rotation = deg_to_rad(-20)
	elif Input.is_action_just_pressed("shoot_right"):
		top.rotation = deg_to_rad(20)
