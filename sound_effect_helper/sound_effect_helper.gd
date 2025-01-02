extends Node

func new_sound(stream, volume, min_pitch = 0, max_pitch = 0):
	var soundbite = SoundBite.new_soundbite(stream, volume, min_pitch, max_pitch)
	call_deferred("add_child", soundbite)
