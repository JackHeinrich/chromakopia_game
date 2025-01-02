extends Node2D

class_name PlaneManager

@export var crosshair_holder: Node2D


var can_shoot = false

var ammo = true

@export var scene_camera: Camera2D

var blast_sound = preload("res://tank/blast.wav")

signal tut_over

signal shot_left

signal shot_right


func _ready():
	if tank_mode:
		$crosshairs/crosshair/AudioStreamPlayer.stream = blast_sound
		$crosshairs/crosshair2/AudioStreamPlayer.stream = blast_sound
		$crosshairs/crosshair/AudioStreamPlayer.volume_db = -17.5
		$crosshairs/crosshair2/AudioStreamPlayer.volume_db = -17.5

func deactivate():
	can_shoot = false
	var tween = get_tree().create_tween()
	tween.tween_property(crosshair_holder, "modulate", Color.TRANSPARENT, GlobalBeatHandler.beats_to_seconds(4))
	await tween.finished
	tut_over.emit()

func activate():
	var tween = get_tree().create_tween()
	tween.tween_property(crosshair_holder, "modulate", Color.WHITE, GlobalBeatHandler.beats_to_seconds(4))
	await tween.finished
	can_shoot = true
	if tank_mode:
		scene_camera.tank_mode()

@export var left_crosshair: Crosshair

@export var right_crosshair: Crosshair

func _process(delta):
	if !can_shoot:
		return
	
	if !ammo:
		return
	
	if Input.is_action_just_pressed("shoot_left"):
		left_crosshair.flash()
		shot_left.emit()
	elif Input.is_action_just_pressed("shoot_right"):
		right_crosshair.flash()
		shot_right.emit()
	
	if Input.is_action_just_pressed("shoot_left") or Input.is_action_just_pressed("shoot_right"):
		scene_camera.apply_shake()
		ammo = false
		await get_tree().create_timer(GlobalBeatHandler.beats_to_seconds(0.25)).timeout
		ammo = true

@export var tank_mode = false

func handle_plane_hit(plane):
	plane.destroy()

func _on_collider_area_entered(area):
	var plane = area.owner
	handle_plane_hit(plane)
