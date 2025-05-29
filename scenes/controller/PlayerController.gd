extends "res://scenes/Controller.gd"

func get_color():
	return Color.MEDIUM_PURPLE


func getNextCommand(_cast:Node, _shape_cast: Node, _delta:float) -> Command:
	var command = Command.new(
			Command.SHOOT if Input.is_action_just_pressed("ui_accept") else Command.MOVE, 
			Vector2(Input.get_axis("ui_left", "ui_right"),
					Input.get_axis("ui_up", "ui_down")))
	return command
