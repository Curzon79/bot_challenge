extends CPU_Module

class_name CPU_Aim_Module

enum Selection {NEAREST, STRONGEST, RANDOM}

@export var accurracy = 0.8
@export var selection = Selection.RANDOM

func call_aim(bot, targets:Array) -> Vector2:
	if (len(targets) == 0):
		return get_random_direction()
	
	var target = get_targets(targets)
	
	return bot.global_position.direction_to(target.global_position)\
			.rotated((randf() - 0.5) * PI * 0.5 * (1.0 - accurracy))

func get_targets(targets:Array):
	match selection:
		Selection.NEAREST:
			return targets[0]
		Selection.STRONGEST:
			return targets[0]
		Selection.RANDOM:
			return targets[0]
	
	return targets[0]


func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
