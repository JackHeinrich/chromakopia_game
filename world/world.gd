extends Node2D

@export var container_state: State

var owner_scene: Node2D

func _ready():
	ScoreKeeper.reset()

func set_sprite(sprite):
	container_state.set_sprite(sprite)

func _on_reset_timer_timeout():
	ScoreKeeper.score_label = null
	ScoreKeeper.total_label = null
	owner_scene.reset()
