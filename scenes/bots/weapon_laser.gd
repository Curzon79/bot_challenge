extends Weapon

class_name WeaponLaser

const Laser = preload("res://scenes/ui/laser.tscn")

#Structure
@export var duration = 1.0
@export var sweep = 45.0

func get_description() -> String:
	return "Shoots Lasers at the enemy.\n\nbase damage: {damage}\nbase frequency: {frequency}/s\nsweep: {sweep} degrees"\
			.format({"damage" : damage, "frequency":base_frequency, "sweep": sweep})

func shoot_weapon(command:Command, bot:CustomBot):
	var new_laser = Laser.instantiate()
	
	new_laser.direction = command.direction
	new_laser.ignore_character = bot
	new_laser.global_position = bot.global_position
	new_laser.time = duration
	new_laser.sweep = sweep
	new_laser.modulate = bot.modulate
	new_laser.damage = bot.bot_definition.get_modifier(bot, BotDefinition.Hook.MOD_DEAL_DAMAGE, damage)
	
	bot.add_child(new_laser)
	
