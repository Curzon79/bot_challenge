extends Node2D

const BOT_SCENE = preload("res://scenes/fighter.tscn")
const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
const TIME_SCENE = preload("res://scenes/ui/game_speed.tscn")
const START_TIMER = preload("res://scenes/ui/321_go.tscn")

var bot_types = []
var player_def = null
var alive_bots = 0

func _ready():
	initialize_bots(BOT_SCENE)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())

func set_bots(bots: Array, player: BotDefinition = null):
	bot_types = bots
	player_def = player

func bot_died():
	alive_bots -= 1
	if (alive_bots == 0):
		next_level()

func player_died():
	#game over -> menu
	var scene = load("res://scenes/menu_game.tscn").instantiate()
	get_tree().root.add_child(scene)
	get_node("/root/room").queue_free()
	
func next_level():
	Progress.progress_difficulty()
	
	var item_select = load("res://scenes/bots/bot_item_select.tscn").instantiate()
	item_select.set_items(1.0)
	add_child(item_select)
	
	item_select.closed.connect(start_next_level)

func start_next_level():
	var scene = load("res://scenes/upgrade_room.tscn").instantiate()
	get_tree().root.add_child(scene)
	get_node("/root/room").queue_free()

func initialize_bots(bot_scene) -> void:
	var starting_positions = get_tree().get_nodes_in_group("Startposition")
	
	alive_bots = bot_types.size()
	#create new bots
	for i in range(bot_types.size()):
		var bot_def = load(bot_types[i])
		
		var bot = null
		if (bot_def is BotDefinition):
			bot = CUSTOM_BOT_SCENE.instantiate()
			bot.set_bot_definition(bot_def)
		else:
			bot = bot_scene.instantiate()
			bot.set_controller(bot_def)
			
		bot.set_color()
		bot.global_position = starting_positions[i + 1].global_position
		bot.died.connect(bot_died)
		
		add_child(bot)
	
		
	#add player bot
	if (player_def != null):
		var player_bot = CUSTOM_BOT_SCENE.instantiate()
		player_bot.set_bot_definition(player_def)
			
		player_bot.set_color()
		player_bot.global_position = starting_positions[0].global_position
		player_bot.died.connect(player_died)
		add_child(player_bot)
