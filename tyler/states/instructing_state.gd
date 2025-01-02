extends State

@export var sprite: Sprite2D

@export var tyler : Node2D

var lock_loop = false

func enter():
	super.enter()
	sprite.frame = 1

var hold_frame = false

func on_beat(beat):
	if beat > 52:
		tyler.global_position = Vector2(128,-120)
		transitioned.emit(self,"gunning_state")
	if beat > 18:
		tyler.global_position = Vector2(128,-120)
		transitioned.emit(self,"grab_state")
	
	if beat == 9:
		lock_loop = true
		sprite.frame = 2
	elif beat == 15:
		lock_loop = true
		sprite.frame = 7
	elif beat == 16:
		sprite.frame = 8
	elif lock_loop:
		lock_loop = false
	
	if beat == 18:
		transitioned.emit(self,"first_walking_state")

func on_measure(measure):
	
	var y_tween_amount = 0.1
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(tyler, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(tyler, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))

	
	if lock_loop:
		return
	if measure % 2 == 0:
		sprite.frame = 1
	else:
		sprite.frame = 0
