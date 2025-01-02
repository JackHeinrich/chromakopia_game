extends State

@export var sprite: Sprite2D

var grab_beat = 47

var cock_beat = 48

var cock_beat2 = 49

@export var tyler: Node2D

func enter():
	super.enter()
	sprite.frame = 9

@export var gun_holder: Node2D

func on_beat(beat):
	var y_tween_amount = 0.1
	
	match beat:
		grab_beat:
			sprite.frame = 10
			gun_holder.show()
		cock_beat:
			sprite.frame = 11
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
			tween.parallel().tween_property(gun_holder, "position:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
			tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
		cock_beat2:
			sprite.frame = 10
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
			tween.parallel().tween_property(gun_holder, "position:y", 0.0, GlobalBeatHandler.beats_to_seconds(0.25))
			tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
		50:
			transitioned.emit(self,"gunning_state")
