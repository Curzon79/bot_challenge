extends Object

class_name Controller

func getNextCommand(_cast:Node, _shape_cast: Node, _delta:float) -> Command:
	var command = Command.new(Command.IDLE, Vector2())
	return command
