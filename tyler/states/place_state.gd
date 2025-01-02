extends State

@export var sprite: Sprite2D

@export var gun_sprite: Sprite2D

func enter():
	super.enter()
	sprite.frame = 9
	gun_sprite.hide()

func on_beat(beat):
	if beat == 81:
		sprite.frame = 4
	
	if beat == 82:
		transitioned.emit(self,"second_walking_state")
		
