extends State

var child = 0

@export var green: ColorRect

@export var reset_timer: Timer

@export var kick: AudioStreamPlayer

func on_half_beat(beat):
	
	if beat < 452:
		return
	
	kick.play()
	
	if beat == 452:
		green.show()
		green.get_child(0).show()
	
	if beat >= 453:
		child += 1
		
		if is_instance_valid(green.get_child(child)):
			green.get_child(child).show()
	
	reset_timer.start()
