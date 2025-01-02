extends State

@export var release_beat: int

@export var beats_to_target: int

@export var target: Vector2

@export var plane : Sprite2D

func on_beat(beat):
	if beat == release_beat:
		var position_tween = get_tree().create_tween()
		
		position_tween.tween_property(plane, "global_position", target, GlobalBeatHandler.beats_to_seconds(beats_to_target))
		
