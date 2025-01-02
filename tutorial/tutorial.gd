extends Node2D

var main_scene: Node2D

signal tut_over

func _ready():
	if main_scene:
		tut_over.connect(main_scene.tut_over)
	$plane_manager.activate()


func _process(delta):
	if Input.is_action_just_pressed("enter"):
		tut_over.emit()

var can_right = false


func _on_plane_manager_tut_over():
	tut_over.emit()

func activate():
	GlobalBeatHandler.begin_tutorial()
	activated = true

var can_left = true

func _on_plane_manager_shot_left():
	if !can_right and can_left:
		$ColorRect/left.hide()
		can_left = false
		await get_tree().create_timer(0.5).timeout
		$ColorRect/right.show()
		can_right = true


var activated = false

func _on_plane_manager_shot_right():
	if can_right and !activated:
		activate()
		can_right = false
		$ColorRect/right.hide()
		$ColorRect/hit_the_planes.show()
