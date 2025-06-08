extends Weapon

class_name WeaponSpawn

#Structure
@export var spawn_bot = "res://scenes/bots/enemies/bee.tres"

func shoot_weapon(command:Command, bot:CustomBot):
	var room = bot.get_parent()
	var spawn_position = Vector2()
	while(! room.is_possible_spawn_position(spawn_position)):
		spawn_position = bot.global_position + Vector2(100, 0).rotated(randf() * 2 * PI)
	
	room.spawn_bot(spawn_bot, spawn_position)
