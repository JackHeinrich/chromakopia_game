extends State

@export var anim_player: AnimationPlayer

func enter():
	super.enter()
	anim_player.play("idle")

func on_beat(beat):
	if beat == 146:
		transitioned.emit(self,"firing_state")
