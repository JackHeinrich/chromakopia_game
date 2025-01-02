extends State

@export var sprite: Sprite2D

@export var release_beat = 40

@export var click_1_beat: int

@export var click_2_beat: int

@export var sound_player1 : AudioStreamPlayer
@export var sound_player2 : AudioStreamPlayer
@export var swipe_sound_player: AudioStreamPlayer

func on_beat(beat):
	if beat == release_beat:
		sprite.hide()
		swipe_sound_player.play()
		
	
	if beat == click_1_beat:
		sound_player1.play()
	elif beat == click_2_beat:
		sound_player2.play()
	
	if beat == 80:
		sprite.show()
		swipe_sound_player.play()
