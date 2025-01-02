extends State

@export var sprite: Sprite2D

@export var target_pos : Vector2

@export var tyler : Node2D

func enter():
	super.enter()
	var tween = get_tree().create_tween()
	tween.tween_property(tyler, "global_position", target_pos, GlobalBeatHandler.beats_to_seconds(28))
	await tween.finished
	transitioned.emit(self,"grab_state")

var frame_offset = 3


func on_measure(measure):
	var y_tween_amount = 0.1
	sprite.frame = frame_offset + (measure - 1)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
