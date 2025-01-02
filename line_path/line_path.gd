extends Path2D

@export var line : Line2D

func _ready():
	line.points = curve.get_baked_points()
