extends Node2D

enum Directions {LEFT, RIGHT}

@export var direction: Directions

@export var x_threshold: float

@export var default_x: float

@export var stop_beat: int

@export var resume_beat: int

func _ready():
	if direction == Directions.RIGHT:
		for child in get_children():
			if child is Soldier:
				child.scale.x = -1
	for child in get_children():
		if child is Soldier:
			child.direction = direction
			child.set_threshold(x_threshold)
			child.set_default(default_x)
			child.set_stop_beat(stop_beat)
			child.set_resume_beat(resume_beat)
