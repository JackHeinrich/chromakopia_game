extends State

@export var particles: GPUParticles2D

@export var rect: Node2D

func on_beat(beat):
	if beat == 212:
		particles.emitting = true
	if beat == 222:
		var tween = get_tree().create_tween()
		tween.tween_property(rect, "global_position:y", -680, GlobalBeatHandler.beats_to_seconds(4))
		tween.play()
