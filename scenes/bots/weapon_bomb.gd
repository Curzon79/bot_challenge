extends Weapon

class_name WeaponBomb

const Bomb = preload("res://scenes/ui/bomb.tscn")

#Structure
@export var time = 1.0

func get_description() -> String:
	return "Deposits mines.\n\nbase damage: {damage}\nbase frequency: {frequency}/s"\
			.format({"damage" : damage, "frequency":base_frequency})


func shoot_weapon(_command:Command, bot:CustomBot):
	var new_bomb = Bomb.instantiate()
	new_bomb.ignore_character = bot
	new_bomb.global_position = bot.global_position
	new_bomb.time = time
	new_bomb.damage = bot.bot_definition.get_modifier(bot, BotDefinition.Hook.MOD_DEAL_DAMAGE, damage)
	new_bomb.modulate = bot.modulate
	bot.get_parent().add_child(new_bomb)

	
