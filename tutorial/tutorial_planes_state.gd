extends State

@export var plane_manager: Node2D

@onready var y_pos = plane_manager.global_position.y

var activated = false

signal tut_over

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
var tut_pattern = [
	PlaneSpawnInfo.new(1,18),
	PlaneSpawnInfo.new(0,26),
	PlaneSpawnInfo.new(1,36),
	PlaneSpawnInfo.new(0,37),
	PlaneSpawnInfo.new(1,38),
	PlaneSpawnInfo.new(1,44),
	PlaneSpawnInfo.new(0,44.5),
	PlaneSpawnInfo.new(1,45.5),
	PlaneSpawnInfo.new(0,46),
	]

var pattern

func deactivate():
	plane_manager.deactivate()

func enter():
	super.enter()
	pattern = tut_pattern

func spawn_plane(direction, beat_offset):
	var plane = GamePlayPlane.new_plane(direction, y_pos, beat_offset)
	plane_manager.call_deferred("add_child", plane)
	plane.position.y = 0

var beat_offset = 2

var indicator_offset = 4

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

@export var exit_beat = 50

func on_beat(beat):
	if beat >= exit_beat:
		deactivate()
	
	for plane_info in pattern:
		if !plane_info.beat:
			continue
		if beat == plane_info.beat - beat_offset:
			spawn_plane(plane_info.direction, beat_offset)
		elif beat == plane_info.beat - indicator_offset:
			spawn_indicator(plane_info.direction)
