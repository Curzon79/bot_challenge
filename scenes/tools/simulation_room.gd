extends Node2D

const Weapons_wins = {
	"res://scenes/bots/parts/weapon_t1_big_cannon.tres" : 0,
	"res://scenes/bots/parts/weapon_t2_big_cannon.tres" : 0,
	"res://scenes/bots/parts/weapon_t3_big_cannon.tres" : 0,
	"res://scenes/bots/parts/weapon_t1_bomb.tres" : 0,
	"res://scenes/bots/parts/weapon_t2_bomb.tres" : 0,
	"res://scenes/bots/parts/weapon_t3_bomb.tres" : 0,
	"res://scenes/bots/parts/weapon_t1_cannon.tres" : 0,
	"res://scenes/bots/parts/weapon_t2_cannon_fast.tres" : 0,
	"res://scenes/bots/parts/weapon_t1_laser.tres" : 0,
	"res://scenes/bots/parts/weapon_t2_laser.tres" : 0,
	"res://scenes/bots/parts/weapon_t3_laser.tres" : 0,
	"res://scenes/bots/parts/weapon_t1_pea_shooter.tres" : 0,
}
var weapon_list = Weapons_wins.keys()
var used_weapons = 0

const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
@export var hull : Hull

func _ready() -> void:
	spawn_bot(get_new_player_bot_defenition(), $playing_field/Startposition.global_position)


func get_new_player_bot_defenition():
	var bot_definition = BotDefinition.new()
	bot_definition.hull = hull
	bot_definition.weapons.clear()	
	bot_definition.weapons.append(weapon_list[used_weapons])
	return bot_definition

func spawn_bot(bot_definition, position:Vector2): 
	var bot_def = bot_definition
		
	var bot = null
	if (bot_def is BotDefinition):
		bot = CUSTOM_BOT_SCENE.instantiate()
		bot.set_bot_definition(bot_def)
		bot.global_position = position 
		add_child(bot)
