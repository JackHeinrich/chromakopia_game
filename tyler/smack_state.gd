extends State

@export var sprite: Sprite2D

@export var slammer: AudioStreamPlayer

@export var fwhip: AudioStreamPlayer

@export var tyler: Node2D

func enter():
	super.enter()
	sprite.frame = 4

func on_beat(beat):
	if beat >= 200:
		tyler.global_position = Vector2(128,-664)
		transitioned.emit(self,"final_state")
	
	if beat == 113:
		sprite.frame = 16
		fwhip.play()
	elif beat == 114:
		sprite.frame = 17
		slammer.play()
	elif beat == 115:
		sprite.frame = 4
	elif beat == 116:
		sprite.hide()
	elif beat == 182:
		transitioned.emit(self,"walking_state_six")
