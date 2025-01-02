extends State

@export var sprite: Sprite2D

@export var tyler: Node2D

@export var exit_tank_pos: Vector2

@export var walk_to_1: Vector2

@export var walk_to_2: Vector2

func enter():
	super.enter()
	
	sprite.show()
	tyler.global_position = exit_tank_pos

var walking_up: bool = false

@export var walk_to_3: Vector2

var current_beat: int = 0

func on_beat(beat):
	if beat == 184:
		var tween = get_tree().create_tween()
		tween.tween_property(tyler,"global_position", walk_to_1, GlobalBeatHandler.beats_to_seconds(6))
		tween.play()
		walking_up = true
	
	if beat == 190:
		var tween = get_tree().create_tween()
		tween.tween_property(tyler,"global_position", walk_to_2, GlobalBeatHandler.beats_to_seconds(2))
		tween.play()
		walking_up = false
		walking_right = true
	
	if beat == 192:
		var tween = get_tree().create_tween()
		tween.tween_property(tyler,"global_position", walk_to_3, GlobalBeatHandler.beats_to_seconds(6))
		tween.play()
		walking_up = true
		walking_right = false
	
	if beat == 198:
		walking_up = false
		sprite.frame = 4
		transitioned.emit(self,"final_state")
	
	current_beat = beat
	
	walk(beat)

var walking_right = false

func walk(beat):
	if walking_up:
		sprite.frame = 3 + (beat%4)
	elif walking_right:
		sprite.frame = 12 + (beat%4)

func on_measure(measure):
	if current_beat <= 184:
		return
	
	var y_tween_amount = 0.1
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
