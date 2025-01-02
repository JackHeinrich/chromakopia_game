extends State

@export var plane_manager: Node2D

@onready var y_pos = plane_manager.global_position.y

var activated = false

class PlaneSpawnInfo:
	var direction: int
	var beat
	var half_beat
	func _init(new_direction: int, new_beat):
		if new_beat is int:
			beat = new_beat
		elif new_beat is float:
			half_beat = new_beat
		direction = new_direction
		beat = new_beat

#first patterns should start at 53
var pattern1 = [
	PlaneSpawnInfo.new(1,53),
	PlaneSpawnInfo.new(1,54),
	PlaneSpawnInfo.new(0,55),
	PlaneSpawnInfo.new(0,56),
	PlaneSpawnInfo.new(1,57),
	PlaneSpawnInfo.new(1,58),
	PlaneSpawnInfo.new(0,59),
	PlaneSpawnInfo.new(0,60),
	PlaneSpawnInfo.new(1,61),
	PlaneSpawnInfo.new(1,62),
	PlaneSpawnInfo.new(0,63),
	PlaneSpawnInfo.new(1,64),
	]

var pattern2 = [
	PlaneSpawnInfo.new(0,53),
	PlaneSpawnInfo.new(1,54),
	PlaneSpawnInfo.new(1,55),
	PlaneSpawnInfo.new(0,56),
	PlaneSpawnInfo.new(1,58),
	PlaneSpawnInfo.new(0,60),
	PlaneSpawnInfo.new(0,61),
	PlaneSpawnInfo.new(1,62),
	PlaneSpawnInfo.new(0,63),
	PlaneSpawnInfo.new(1,64),
	]

var pattern3 = [
	PlaneSpawnInfo.new(1,52),
	PlaneSpawnInfo.new(0,53),
	PlaneSpawnInfo.new(1,54),
	PlaneSpawnInfo.new(0,56),
	PlaneSpawnInfo.new(1,58),
	PlaneSpawnInfo.new(0,60),
	PlaneSpawnInfo.new(1,61),
	PlaneSpawnInfo.new(0,62),
	PlaneSpawnInfo.new(1,64),
	]

var second_pattern1 = [
	PlaneSpawnInfo.new(1,68),
	PlaneSpawnInfo.new(0,69),
	PlaneSpawnInfo.new(1,70),
	PlaneSpawnInfo.new(1,71),
	PlaneSpawnInfo.new(0,72),
	PlaneSpawnInfo.new(0,73),
	PlaneSpawnInfo.new(1,74),
	PlaneSpawnInfo.new(0,75),
	PlaneSpawnInfo.new(1,76),
	PlaneSpawnInfo.new(1,77),
	PlaneSpawnInfo.new(0,78),
	PlaneSpawnInfo.new(1,79),
	PlaneSpawnInfo.new(0,79.5),
	PlaneSpawnInfo.new(1,80),
	]

var second_pattern2 = [
	PlaneSpawnInfo.new(1,68),
	PlaneSpawnInfo.new(1,69),
	PlaneSpawnInfo.new(1,70),
	PlaneSpawnInfo.new(0,71),
	PlaneSpawnInfo.new(1,72),
	PlaneSpawnInfo.new(0,73),
	PlaneSpawnInfo.new(0,74),
	PlaneSpawnInfo.new(0,75),
	PlaneSpawnInfo.new(1,76),
	PlaneSpawnInfo.new(1,77),
	PlaneSpawnInfo.new(0,78),
	PlaneSpawnInfo.new(0,79),
	PlaneSpawnInfo.new(1,79.5),
	PlaneSpawnInfo.new(0,80),
	]

var second_pattern3 = [
	PlaneSpawnInfo.new(1,68),
	PlaneSpawnInfo.new(1,69),
	PlaneSpawnInfo.new(0,71),
	PlaneSpawnInfo.new(0,72),
	PlaneSpawnInfo.new(1,73),
	PlaneSpawnInfo.new(0,75),
	PlaneSpawnInfo.new(1,77),
	PlaneSpawnInfo.new(0,79),
	PlaneSpawnInfo.new(1,79.5),
	PlaneSpawnInfo.new(0,80),
	]

var first_patterns = [pattern1, pattern2, pattern3]

var second_patterns = [second_pattern1, second_pattern2, second_pattern3]

var pattern

func deactivate():
	plane_manager.deactivate()

func enter():
	super.enter()
	pattern = first_patterns.pick_random()

func spawn_plane(direction, beat_offset):
	ScoreKeeper.increment_total()
	var plane = GamePlayPlane.new_plane(direction, y_pos, beat_offset)
	plane_manager.call_deferred("add_child", plane)
	plane.position.y = 0

var beat_offset = 2

var indicator_offset = 4

var swap_to_second_beat = 64

func spawn_indicator(direction):
	var indicator_scene = preload("res://gameplay_plane/indicator_particle.tscn")
	var new_indicator = indicator_scene.instantiate()
	plane_manager.call_deferred("add_child", new_indicator)
	var direction_offset
	if direction == 1:
		direction_offset = -1
	elif direction == 0:
		direction_offset = 1
		new_indicator.scale.x = -1
	new_indicator.position = Vector2.ZERO
	new_indicator.global_position.x = 128 + (128 * direction_offset)

func on_half_beat(half_beat):
	for plane_info in pattern:
		# Check if the plane spawn should happen on a half-beat
		if plane_info.half_beat != null:
			if half_beat == ((plane_info.half_beat - beat_offset) * 2):
				spawn_plane(plane_info.direction, beat_offset)
			elif half_beat == ((plane_info.half_beat - indicator_offset) * 2):
				spawn_indicator(plane_info.direction)

@export var exit_beat = 80

func on_beat(beat):
	if beat >= exit_beat:
		deactivate()
	
	
	if beat == swap_to_second_beat:
		pattern = second_patterns.pick_random()
	
	if beat >= 46 and not activated: #beat when camera moves to static position
		plane_manager.activate()
		activated = true
	
	for plane_info in pattern:
		if !plane_info.beat:
			continue
		if beat == plane_info.beat - beat_offset:
			spawn_plane(plane_info.direction, beat_offset)
		elif beat == plane_info.beat - indicator_offset:
			spawn_indicator(plane_info.direction)
