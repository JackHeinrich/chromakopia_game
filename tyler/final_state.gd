extends State

@export var sprite: Sprite2D

@export var tyler: Node2D

@export var camera: GameCamera

@export var camera_y_pos: int

func enter():
	super.enter()
	camera.mode = GameCamera.Modes.STATIC
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position:y", camera_y_pos, GlobalBeatHandler.beats_to_seconds(4))
	tween.play()

func on_beat(beat):
	
	if beat == 202:
		bounce()
		sprite.frame = 18
	
	if beat == 206:
		bounce()
		sprite.frame = 19
	
	if beat == 210:
		bounce()
		sprite.frame = 20
	
	if beat == 212:
		sprite.frame = 4
	
	

func bounce():
	var y_tween_amount = 0.1
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
