extends "res://scenes/Controller.gd"

var duration = 0
var last_command = Command.new(Command.IDLE, Vector2())
var shoot_timeout = 0

func get_color():
	return Color.CADET_BLUE


func getNextCommand(_cast:Node, _shape_cast: Node, _delta:float) -> Command:
	return Command.new(Command.SHOOT, 
					get_direction())
	
func get_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
