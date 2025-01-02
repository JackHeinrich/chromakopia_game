extends Node2D
class_name Soldier

var x_threshold = -32
var default_x = 288

var direction

var stop_beat

var resume_beat

@export var walking_state : State

func set_threshold(new_threshold):
	x_threshold = new_threshold
	walking_state.x_threshold = new_threshold

func set_default(new_default):
	default_x = new_default
	walking_state.default_x = new_default

func set_stop_beat(new_stop_beat):
	stop_beat = new_stop_beat
	walking_state.stop_beat = new_stop_beat

func set_resume_beat(new_resume_beat):
	resume_beat = new_resume_beat
	walking_state.resume_beat = new_resume_beat
