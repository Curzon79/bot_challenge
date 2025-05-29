extends Resource

class_name Weapon

enum Weapon_Type {Bullet, Laser}
const Bullet = preload("res://scenes/projectile.tscn")

#Structure
@export var cost = 100

@export var base_frequency = 0.2
@export var type = Weapon_Type.Bullet
@export var damage = 1

#Representtaion
@export var name: String
@export var icon: Texture2D
@export var sprite: Texture2D

func get_frequency():
	return base_frequency 

func shoot_weapon(command:Command, bot:CustomBot):
	match type:
		Weapon_Type.Bullet:
			var new_bullet = Bullet.instantiate()
			new_bullet.direction = command.direction
			new_bullet.ignore_character = bot
			new_bullet.global_position = bot.global_position
			new_bullet.get_node("CollisionShape2D/Light").modulate = bot.modulate
			bot.get_parent().add_child(new_bullet)
		Weapon_Type.Laser:
			pass
	
