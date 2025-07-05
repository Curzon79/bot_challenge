extends Node2D

var Weapons_wins = {
	"res://scenes/bots/parts/weapon_t1_big_cannon.tres" : 0,
	"res://scenes/bots/parts/weapon_t2_big_cannon.tres" : 0,
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
var curr_rounds_done = 0

const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
const PLAYER_CUSTOM_BOT_SCENE = preload("res://scenes/bots/player_custom_bot.tscn")
#@export var hull : Hull
#@export var enemy_bot_definition : BotDefinition
@export var base_bot_definition : BotDefinition

var bot1
var bot2


func _ready() -> void:
	Engine.time_scale = 2.0
	print_result()
	start_new_round()


func start_new_round():
	if used_weapons >= weapon_list.size():
		print(Weapons_wins)
		return
		
	spawn_bot(PLAYER_CUSTOM_BOT_SCENE, get_new_player_bot_definition(), $playing_field/Startposition.global_position, on_bot_1_died, 1)
	spawn_bot(CUSTOM_BOT_SCENE, base_bot_definition, $playing_field/Startposition2.global_position, on_bot_2_died, 2)

	curr_rounds_done += 1
	if curr_rounds_done > 100:
		curr_rounds_done = 0
		used_weapons += 1
		
		print_result()

func print_result():
	var file = FileAccess.open("res://simulation.dat", FileAccess.WRITE)
	file.store_string(str(Weapons_wins))

func get_new_player_bot_definition():
	var bot_definition = base_bot_definition.duplicate()
	bot_definition.weapons.clear()	
	var weapon = weapon_list[used_weapons]
	bot_definition.weapons.append(load(weapon))
	return bot_definition

func spawn_bot(bot_scene, bot_def, position:Vector2, signal_, bot_number): 
	if (bot_def is BotDefinition):
		var bot = bot_scene.instantiate()
		bot.set_bot_definition(bot_def)
		bot.global_position = position 
		bot.connect("died", signal_)
		call_deferred("add_child", bot)
		if bot_number == 1:
			bot1 = bot
		else:
			bot2 = bot

func clear_bots():
	if bot1:
		bot1.queue_free()
	if bot2:
		bot2.queue_free()

func on_bot_1_died():
	Weapons_wins[weapon_list[used_weapons]] += 1
	clear_bots()
	start_new_round()

func on_bot_2_died():
	clear_bots()
	start_new_round()
