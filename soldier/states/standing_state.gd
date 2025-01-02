extends State

@export var release_beat = 18

@export var soldier : Node2D

@export var sprite : Sprite2D

func enter():
	super.enter()
	soldier.position.x += randi_range(-1.0, 1.0)
	soldier.position.y += randi_range(-1.0, 1.0)

func on_beat(beat):
	if beat == release_beat - 2:
		sprite.frame = 1
	elif beat >= release_beat:
		transitioned.emit(self,"walking_state")
