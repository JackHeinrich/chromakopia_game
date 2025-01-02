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
	PlaneSpawnInfo.new(1,147),
	PlaneSpawnInfo.new(0,147.5),
	PlaneSpawnInfo.new(1,148),
	PlaneSpawnInfo.new(0,149),
	PlaneSpawnInfo.new(0,151),
	PlaneSpawnInfo.new(1,151.5),
	PlaneSpawnInfo.new(0,152),
	PlaneSpawnInfo.new(0,153),
	PlaneSpawnInfo.new(1,155),
	PlaneSpawnInfo.new(0,155.5),
	PlaneSpawnInfo.new(1,156),
	PlaneSpawnInfo.new(0,157),
	PlaneSpawnInfo.new(1,158),
	PlaneSpawnInfo.new(0,159),
	PlaneSpawnInfo.new(1,159.5),
	PlaneSpawnInfo.new(0,160),
	PlaneSpawnInfo.new(0,161),
	]

var pattern2 = [
	PlaneSpawnInfo.new(0,147),
	PlaneSpawnInfo.new(0,148),
	PlaneSpawnInfo.new(1,148.5),
	PlaneSpawnInfo.new(1,149.5),
	PlaneSpawnInfo.new(1,151),
	PlaneSpawnInfo.new(1,152),
	PlaneSpawnInfo.new(0,152.5),
	PlaneSpawnInfo.new(0,153.5),
	PlaneSpawnInfo.new(0,155),
	PlaneSpawnInfo.new(0,156),
	PlaneSpawnInfo.new(1,156.5),
	PlaneSpawnInfo.new(1,157.5),
	PlaneSpawnInfo.new(0,158),
	PlaneSpawnInfo.new(1,158.5),
	PlaneSpawnInfo.new(1,159.5),
	PlaneSpawnInfo.new(0,160),
	PlaneSpawnInfo.new(1,160.5),
	PlaneSpawnInfo.new(1,161.5),
	]

var pattern3 = [
	PlaneSpawnInfo.new(0,147),
	PlaneSpawnInfo.new(1,147.5),
	PlaneSpawnInfo.new(0,148),
	PlaneSpawnInfo.new(0,149),
	PlaneSpawnInfo.new(0,150),
	PlaneSpawnInfo.new(1,151),
	PlaneSpawnInfo.new(0,151.5),
	PlaneSpawnInfo.new(1,152),
	PlaneSpawnInfo.new(1,153),
	PlaneSpawnInfo.new(1,154),
	PlaneSpawnInfo.new(0,155),
	PlaneSpawnInfo.new(1,155.5),
	PlaneSpawnInfo.new(0,156),
	PlaneSpawnInfo.new(0,157),
	PlaneSpawnInfo.new(0,158),
	PlaneSpawnInfo.new(0,159),
	PlaneSpawnInfo.new(1,159.5),
	PlaneSpawnInfo.new(0,160),
	PlaneSpawnInfo.new(1,160.5),
	PlaneSpawnInfo.new(0,161),
	]

var second_pattern1 = [
	PlaneSpawnInfo.new(1, 162),
	PlaneSpawnInfo.new(0, 162.5),
	PlaneSpawnInfo.new(1, 163),
	PlaneSpawnInfo.new(0, 164),
	PlaneSpawnInfo.new(0, 166),
	PlaneSpawnInfo.new(1, 166.5),
	PlaneSpawnInfo.new(0, 167),
	PlaneSpawnInfo.new(0, 168),
	PlaneSpawnInfo.new(1, 170),
	PlaneSpawnInfo.new(0, 170.5),
	PlaneSpawnInfo.new(1, 171),
	PlaneSpawnInfo.new(0, 172),
	PlaneSpawnInfo.new(1, 173),
	PlaneSpawnInfo.new(0, 174),
	PlaneSpawnInfo.new(1, 174.5),
	PlaneSpawnInfo.new(0, 175),
	PlaneSpawnInfo.new(0, 176),
	]

var second_pattern2 = [
	PlaneSpawnInfo.new(0, 162),
	PlaneSpawnInfo.new(0, 163),
	PlaneSpawnInfo.new(1, 163.5),
	PlaneSpawnInfo.new(1, 164.5),
	PlaneSpawnInfo.new(1, 166),
	PlaneSpawnInfo.new(1, 167),
	PlaneSpawnInfo.new(0, 167.5),
	PlaneSpawnInfo.new(0, 168.5),
	PlaneSpawnInfo.new(0, 170),
	PlaneSpawnInfo.new(0, 171),
	PlaneSpawnInfo.new(1, 171.5),
	PlaneSpawnInfo.new(1, 172.5),
	PlaneSpawnInfo.new(0, 173),
	PlaneSpawnInfo.new(1, 173.5),
	PlaneSpawnInfo.new(1, 174.5),
	PlaneSpawnInfo.new(0, 175),
	PlaneSpawnInfo.new(1, 175.5),
	PlaneSpawnInfo.new(1, 176.5),
	]

var second_pattern3 = [
	PlaneSpawnInfo.new(0, 162),
	PlaneSpawnInfo.new(1, 162.5),
	PlaneSpawnInfo.new(0, 163),
	PlaneSpawnInfo.new(0, 164),
	PlaneSpawnInfo.new(0, 165),
	PlaneSpawnInfo.new(1, 166),
	PlaneSpawnInfo.new(0, 166.5),
	PlaneSpawnInfo.new(1, 167),
	PlaneSpawnInfo.new(1, 168),
	PlaneSpawnInfo.new(1, 169),
	PlaneSpawnInfo.new(0, 170),
	PlaneSpawnInfo.new(1, 170.5),
	PlaneSpawnInfo.new(0, 171),
	PlaneSpawnInfo.new(0, 172),
	PlaneSpawnInfo.new(0, 173),
	PlaneSpawnInfo.new(0, 174),
	PlaneSpawnInfo.new(1, 174.5),
	PlaneSpawnInfo.new(0, 175),
	PlaneSpawnInfo.new(1, 175.5),
	PlaneSpawnInfo.new(0, 176),

	]

var first_patterns = [pattern1, pattern2, pattern3]

var second_patterns = [second_pattern1, second_pattern2, second_pattern3]

var pattern

func deactivate():
	plane_manager.deactivate()

func enter():
	super.enter()
	pattern = first_patterns.pick_random()
	second_patterns.remove_at(first_patterns.find(pattern))

func spawn_plane(direction, beat_offset):
	ScoreKeeper.increment_total()
	var plane = GamePlayPlane.new_plane(direction, y_pos, beat_offset)
	plane_manager.call_deferred("add_child", plane)
	plane.position.y = 0

var beat_offset = 2

var indicator_offset = 4

var swap_to_second_beat = 162

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

@export var exit_beat = 178

func on_beat(beat):
	if beat >= exit_beat:
		deactivate()
	
	
	if beat == swap_to_second_beat:
		pattern = second_pattern1
	
	if beat >= 142 and not activated: #beat when camera moves to static position
		plane_manager.activate()
		activated = true
	
	for plane_info in pattern:
		if !plane_info.beat:
			continue
		if beat == plane_info.beat - beat_offset:
			spawn_plane(plane_info.direction, beat_offset)
		elif beat == plane_info.beat - indicator_offset:
			spawn_indicator(plane_info.direction)
