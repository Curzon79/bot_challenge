extends Node2D

const BOT_SCENE = preload("res://scenes/fighter.tscn")
const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
const TIME_SCENE = preload("res://scenes/ui/game_speed.tscn")
const START_TIMER = preload("res://scenes/ui/321_go.tscn")

var bot_types = []

func _ready():
	initialize_bots(BOT_SCENE)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())

func set_bots(bots: Array):
	bot_types = bots

func initialize_bots(bot_scene) -> void:
	var starting_positions = get_tree().get_nodes_in_group("Startposition")
	
	#create new bots
	for i in range(len(bot_types)):
		var bot_def = load(bot_types[i])
		
		var bot = null
		if (bot_def is BotDefinition):
			bot = CUSTOM_BOT_SCENE.instantiate()
			bot.set_bot_definition(bot_def)
		else:
			bot = bot_scene.instantiate()
			bot.set_controller(bot_def)
			
		bot.set_color()
		bot.global_position = starting_positions[i].global_position
		add_child(bot)
