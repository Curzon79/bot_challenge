extends "res://scenes/Controller.gd"

func getNextCommand(_cast:Node, _shape_cast: Node, _delta:float) -> Command:
	var command = Command.new(
			Command.SHOOT if Input.is_action_just_pressed("controler_shot") else Command.MOVE, 
			Vector2(
			Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
			Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
			).limit_length(1.0) if  Input.is_action_just_pressed("controler_shot") else 
			Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
			).limit_length(1.0))
	return command
