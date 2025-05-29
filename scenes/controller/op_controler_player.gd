extends "res://scenes/Controller.gd"

var rng = RandomNumberGenerator.new()

const frequency = 20
const spread = 40

var max_direction_change = 0.05
@export var snapy_controls = true

var curr_velocity : Vector2

var time = 0

func get_color():
	return Color.BLUE
	


func getNextCommand(cast:Node, _shape_cast: Node, delta:float) -> Command:
	curr_velocity.x =+ move_toward(curr_velocity.x, get_move_direction().x, max_direction_change)
	curr_velocity.y =+ move_toward(curr_velocity.y, get_move_direction().y, max_direction_change)
	if get_move_direction() == Vector2(0, 0):
		curr_velocity = get_move_direction()
	time += delta
	cast.get_parent().scale.y = 1.2
	cast.get_parent().scale.x = 1.2
	if Input.is_action_pressed("controler_shot"):
		cheat_shoot(cast)
	var command = Command.new(
		Command.MOVE,
		get_move_direction() if snapy_controls else curr_velocity.normalized())
			
	return command

func get_move_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		).limit_length(1.0)

func get_aim_direction():
	return Vector2(
		Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
		Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		).limit_length(1.0)
func cheat_shoot(cast):
	var pitch = rng.randf_range(1.00, 1.7)
	cast.get_parent().get_node("AudioStreamPlayer").pitch_scale = pitch
	cast.get_parent().get_node("AudioStreamPlayer").play()
	var new_bullet = cast.get_parent().bullet.instantiate()
	new_bullet.direction = get_aim_direction()
	new_bullet.ignore_character = cast.get_parent()
	new_bullet.global_position = cast.get_parent().global_position
	cast.get_parent().get_parent().add_child(new_bullet)
	var second_bullet = cast.get_parent().bullet.instantiate()
	second_bullet.direction = get_aim_direction().rotated(deg_to_rad(sin(time * frequency) * spread))
	second_bullet.ignore_character = cast.get_parent()
	second_bullet.global_position = cast.get_parent().global_position
	cast.get_parent().get_parent().add_child(second_bullet)
