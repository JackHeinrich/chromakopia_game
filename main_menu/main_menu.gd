extends Node2D

signal enter_pressed

@export var owner_scene: Node2D

func set_owner_scene(node):
	owner_scene = node

func _process(delta):
	if Input.is_action_just_pressed("enter"):
		owner_scene.to_tut()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
