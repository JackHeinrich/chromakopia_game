extends State

@export var screamer: Node2D

@export var target_pos : Vector2

@export var sprite: Sprite2D

@export var fire_sprite: Sprite2D

func on_half_beat(half_beat):
	sprite.frame = half_beat % 2
	fire_sprite.frame = (half_beat % 3)
	var y_tween_amount = 0.1
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(screamer, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(screamer, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))

func on_beat(beat):
	if beat == 90:
		var tween = get_tree().create_tween()
		tween.tween_property(screamer, "global_position", target_pos, GlobalBeatHandler.beats_to_seconds(5))
