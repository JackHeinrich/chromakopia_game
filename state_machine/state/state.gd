extends Node
class_name State

signal transitioned

var beat_handler = GlobalBeatHandler

func on_measure(measure):
	pass

func on_beat(beat):
	pass

func enter():
	GlobalBeatHandler.on_beat.connect(on_beat)
	GlobalBeatHandler.on_measure.connect(on_measure)
	GlobalBeatHandler.on_half_beat.connect(on_half_beat)

func exit():
	GlobalBeatHandler.on_beat.disconnect(on_beat)
	GlobalBeatHandler.on_measure.disconnect(on_measure)
	GlobalBeatHandler.on_half_beat.disconnect(on_half_beat)

func on_half_beat(half_beat):
	pass

func update(delta):
	pass

func physics_update(delta):
	pass
