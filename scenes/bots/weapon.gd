extends EffectResource

class_name Weapon

const Bullet = preload("res://scenes/projectile.tscn")

#Structure
@export var base_frequency = 0.2
@export var damage = 1.0

func get_frequency():
	return base_frequency 

func shoot_weapon(command:Command, bot:CustomBot):
	var new_bullet = Bullet.instantiate()
	new_bullet.set_size(sqrt(damage), damage)
	new_bullet.direction = command.direction
	new_bullet.ignore_character = bot
	new_bullet.global_position = bot.global_position
	new_bullet.get_node("CollisionShape2D/Light").modulate = bot.modulate
	bot.get_parent().add_child(new_bullet)

	
