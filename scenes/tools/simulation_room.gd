extends Node2D

const Weapons = {
	"res://scenes/bots/parts/weapon_t1_big_cannon.tres" : "big_cannon 1",
	"res://scenes/bots/parts/weapon_t2_big_cannon.tres" : "big_cannon 2",
	"res://scenes/bots/parts/weapon_t3_big_cannon.tres" : "big_cannon 3",
	"res://scenes/bots/parts/weapon_t1_bomb.tres" : "bomb 1",
	"res://scenes/bots/parts/weapon_t2_bomb.tres" : "bomb 2",
	"res://scenes/bots/parts/weapon_t3_bomb.tres" : "bomb 3",
	"res://scenes/bots/parts/weapon_t1_cannon.tres" : "cannon 1",
	"res://scenes/bots/parts/weapon_t2_cannon_fast.tres" : "cannon 2",
	"res://scenes/bots/parts/weapon_t1_laser.tres" : "laser 1",
	"res://scenes/bots/parts/weapon_t2_laser.tres" : "laser 2",
	"res://scenes/bots/parts/weapon_t3_laser.tres" : "laser 3",
	"res://scenes/bots/parts/weapon_t1_pea_shooter.tres" : "pea shooter 1",
}
var used_weapons = 0

const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
@export var hull : Hull


func get_new_player_bot_defenition():
	var bot_definition = BotDefinition.new()
	bot_definition.hull = hull
	bot_definition.weapons.clear()
	bot_definition.weapons.append(Weapons[used_weapons])
	return BotDefinition

func spawn_bot(bot_definition, position:Vector2):
	var bot_def = load(bot_definition)
		
	var bot = null
	if (bot_def is BotDefinition):
		bot = CUSTOM_BOT_SCENE.instantiate()
		bot.set_bot_definition(bot_def)
		bot.global_position = position 
		add_child(bot)
