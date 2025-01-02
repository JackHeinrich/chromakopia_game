extends Node2D

@export var sprite: Sprite2D

var tutorial_scene = preload("res://tutorial/tutorial.tscn")

var tutorial

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

@export var main_menu: Node2D

var game_scene = preload("res://world/world.tscn")

var gray_gradient = preload("res://gradients/chromakopia_palette.tres")

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

func to_tut():
	main_menu.queue_free()
	sprite.material = preload("res://main/main_color_effect_material.tres")
	sprite.material.set_shader_parameter("gradient", gray_gradient)
	var new_tutorial = tutorial_scene.instantiate()
	new_tutorial.main_scene = self
	$game_viewport.add_child(new_tutorial)
	tutorial = new_tutorial

var game = null

var main_menu_scene = preload("res://main_menu/main_menu.tscn")

func reset():
	game.queue_free()
	var new_menu = main_menu_scene.instantiate()
	sprite.material = null
	$game_viewport.add_child(new_menu)
	new_menu.set_owner_scene(self)
	main_menu = new_menu
	sprite.material = null

func tut_over():
	tutorial.queue_free()
	tutorial = null
	var new_world = game_scene.instantiate()
	new_world.owner_scene = self
	$game_viewport.add_child(new_world)
	new_world.set_sprite(sprite)
	GlobalBeatHandler.begin_chroma()
	game = new_world
