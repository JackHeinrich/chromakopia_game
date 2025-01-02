extends State

@export var soldier : Soldier

@export var x_threshold : float

@export var default_x : float

@export var dust_particles : PackedScene

@export var sprite : Sprite2D

func enter():
	super.enter()
	sprite.frame = 2
	stop_beat = soldier.stop_beat
	resume_beat = soldier.resume_beat

var direction = 1

var stop_beat: int

var resume_beat: int

var locked = false

func on_beat(beat):
	if beat == stop_beat:
		sprite.frame = 3
		locked = true
	elif beat == resume_beat:
		locked = false

func on_measure(measure):
	if locked:
		return
	
	if measure % 2 == 0:
		sprite.frame = 1
	else:
		sprite.frame = 2
	
	var y_tween_amount = randf_range(0.0, 0.2)
	
	if soldier.direction == 1:
		direction = -1
	
	var step_vector = Vector2(-8, 0) * direction
		
	var new_dust = dust_particles.instantiate()
	soldier.add_child(new_dust)
	new_dust.global_position = soldier.global_position
		
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(soldier, "global_position", soldier.global_position + step_vector, GlobalBeatHandler.beats_to_seconds(0.5))
	tween.parallel().tween_property(soldier, "scale:y", 1 + y_tween_amount, GlobalBeatHandler.beats_to_seconds(0.25))
	tween.tween_property(soldier, "scale:y", 1.0, GlobalBeatHandler.beats_to_seconds(0.25))
	await tween.finished
