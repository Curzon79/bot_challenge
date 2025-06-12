extends CPU_Module

class_name CPU_Aim_Module

enum Selection {
	NEAREST_ENEMY, 
	STRONGEST_ENEMY, 
	RANDOM_ENEMY, 
	WALL, 
	FORWARD,
	NONE}

@export var accurracy = 0.8
@export var selection = Selection.RANDOM_ENEMY
@export var spread_type = Aim.SpreadType.RANDOM

func call_aim(bot:CustomBot, targets:Array, vision_all:Dictionary) -> Aim:
	var curr_accurracy = bot.bot_definition.get_modifier(bot, BotDefinition.Hook.MOD_AIM, accurracy)

	if (selection == Selection.NONE):
		return Aim.new(Vector2(), curr_accurracy, spread_type)

	if (selection == Selection.FORWARD):
		return Aim.new(bot.controller.last_command.direction, curr_accurracy, spread_type)

	if (selection == Selection.WALL):
		return Aim.new(get_direction_to_wall(bot.global_position, vision_all) * -1, curr_accurracy, spread_type)

	if (len(targets) == 0):
		return Aim.new(Vector2(), curr_accurracy, spread_type)
		
	var target = get_targets(targets)
	return Aim.new(bot.global_position.direction_to(target.global_position), curr_accurracy, spread_type)

func get_targets(targets:Array):
	match selection:
		Selection.NEAREST_ENEMY:
			return targets[0]
		Selection.STRONGEST_ENEMY:
			return targets[0]
		Selection.RANDOM_ENEMY:
			return targets[0]
	
	return targets[0]

func get_direction_to_wall(position: Vector2, vision_all):
	var direction = Vector2()
	for item in vision_all.keys():
		for pos in vision_all[item]:
			var vector_to_wall = pos - position
			direction += vector_to_wall.normalized() * 10 / (10 + vector_to_wall.length())
	return direction.normalized() 

func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
