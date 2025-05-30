extends CPU_Module

class_name CPU_Move_Module

enum Target {ENEMY, WALLS}

#Structure
@export var target = Target.ENEMY
@export var target_distance = 20


#returns the forces for the target move
func call_move(bot:CustomBot):
	var controller = bot.controller
	match target:
		Target.ENEMY:
			var enemy_position = get_direction_to_closest_enemy(bot.global_position, controller.vision_enemies)
			return get_force_to_position(bot.global_position, enemy_position, target_distance)
		Target.WALLS:
			pass
			
	return Vector2()


func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()

func get_direction_to_closest_enemy(position:Vector2, vision_enemies:Dictionary) -> Vector2:
	var nearest_enemy = null
	var min_dist = 1000000.0
	for enemy in vision_enemies:
		var dist = position.distance_squared_to(vision_enemies[enemy])
		if (dist < min_dist):
			min_dist = dist
			nearest_enemy = enemy

	if (nearest_enemy == null):
		return Vector2()
		
	return nearest_enemy.global_position


func get_force_to_position(position:Vector2, target_position:Vector2, target_distance:float) -> Vector2:
	var direction = target_position - position
	var factor = direction.length() - target_distance
	return direction.normalized() * factor
