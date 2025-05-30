extends Weapon

class_name WeaponLaser

const Laser = preload("res://scenes/laser.tscn")

#Structure
@export var duration = 1.0
@export var sweep = 45.0


func shoot_weapon(command:Command, bot:CustomBot):
	var new_laser = Laser.instantiate()
	new_laser.direction = command.direction
	new_laser.ignore_character = bot
	new_laser.global_position = bot.global_position
	new_laser.time = duration
	new_laser.sweep = sweep
	new_laser.modulate = bot.modulate
	new_laser.damage = damage
	bot.get_parent().add_child(new_laser)
	
