extends Sprite2D

class_name Crosshair

@export var animation_player: AnimationPlayer

func flash():
	animation_player.stop()
	animation_player.play("flash")
	play_sound()

@export var sound_player: AudioStreamPlayer

func play_sound():
	sound_player.pitch_scale = 1.0 + randf_range(-0.2, 0.0)
	sound_player.play()
