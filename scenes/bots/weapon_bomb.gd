extends Weapon

class_name WeaponBomb

const Bomb = preload("res://scenes/bomb.tscn")

#Structure
@export var time = 1.0

func shoot_weapon(_command:Command, bot:CustomBot):
	var new_bomb = Bomb.instantiate()
	new_bomb.ignore_character = bot
	new_bomb.global_position = bot.global_position
	new_bomb.time = time
	new_bomb.damage = damage
	new_bomb.modulate = bot.modulate
	bot.get_parent().add_child(new_bomb)

	
