extends "res://scenes/Controller.gd"

var duration = 0
var last_command = Command.new(Command.IDLE, Vector2())
var shoot_timeout = 0

func get_color():
	return Color.WEB_GRAY


func getNextCommand(_cast:Node, _shape_cast: Node, delta:float) -> Command:
	shoot_timeout -= delta
	
	if shoot_timeout <= 0:
		shoot_timeout = 0.20
		return Command.new(Command.SHOOT, 
					get_direction())
		
	if (duration > 0):
		duration -= 1
		return last_command
	
	last_command = Command.new(Command.MOVE, 
	get_direction())
	duration = 20
	
	return last_command

func get_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
