extends State

@export var static_beat1: int

@export var return_beat1: int

@export var static_beat2: int

@export var return_beat2: int

@export var static_pos1: Vector2

@export var static_pos2: Vector2

@export var camera: GameCamera

@export var return_from_static1 = 80

@export var player: Node2D

var return_from_static2 = 178

func on_beat(beat):
	var tween
	var tween_beats = 4
	if beat == static_beat1:
		camera.mode = camera.Modes.DOLLY
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(camera, "global_position", static_pos1, GlobalBeatHandler.beats_to_seconds(tween_beats))
	
	if beat == return_from_static1:
		tween = get_tree().create_tween()
		tween.tween_property(camera, "global_position", player.global_position, GlobalBeatHandler.beats_to_seconds(2))
		await tween.finished
		camera.mode = camera.Modes.FOLLOWING
	
	if beat == return_from_static2:
		tween = get_tree().create_tween()
		tween.tween_property(camera, "global_position", player.global_position, GlobalBeatHandler.beats_to_seconds(2))
		await tween.finished
		camera.mode = camera.Modes.FOLLOWING
	
	
	if beat == static_beat2:
		camera.mode = camera.Modes.DOLLY
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(camera, "global_position", static_pos2, GlobalBeatHandler.beats_to_seconds(tween_beats))
	
