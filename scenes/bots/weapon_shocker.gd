extends "res://scenes/bots/weapon.gd"

@export var duration = 0.2
@export var size = 1.0

const Shocker = preload("res://scenes/shocker.tscn")

func shoot_weapon(command:Command, bot:CustomBot):
	var new_shocker = Shocker.instantiate()
	new_shocker.duration = duration
	new_shocker.ignore_character = bot
	new_shocker.get_node("visuals/CPUParticles2D").set_deferred("shader_parameter/color", bot.modulate) 
	new_shocker.size = size
	bot.add_child(new_shocker)

	
