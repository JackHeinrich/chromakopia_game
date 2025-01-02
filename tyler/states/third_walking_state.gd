extends State

@export var sprite: Sprite2D

@export var tyler: Node2D

@export var target_pos: Vector2

var locked = false

func enter():
	super.enter()
	sprite.frame = 4
	var tween = get_tree().create_tween()
	tween.tween_property(tyler,"global_position",target_pos, GlobalBeatHandler.beats_to_seconds(4))
	
var frame_offset = 3

func on_beat(beat):
	if beat == 90:
		sprite.frame = 4
		locked = true
	
	if beat == 96:
		transitioned.emit(self,"fourth_walking_state")

func on_measure(measure):
	if locked:
		return
	
	var y_tween_amount = 0.1
	sprite.frame = frame_offset + (measure - 1)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
