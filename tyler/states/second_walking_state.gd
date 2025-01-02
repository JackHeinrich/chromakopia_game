extends State

@export var tyler: Node2D

@export var first_location: Vector2

@export var sprite: Sprite2D

func enter():
	super.enter()
	var tween = get_tree().create_tween()
	tween.tween_property(tyler, "global_position", first_location, GlobalBeatHandler.beats_to_seconds(4))
	await tween.finished
	transitioned.emit(self,"third_walking_state")

var frame_offset = 12

func on_measure(measure):
	var y_tween_amount = 0.1
	sprite.frame = frame_offset + (measure - 1)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
