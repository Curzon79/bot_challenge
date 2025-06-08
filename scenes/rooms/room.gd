extends Node2D

const BOT_SCENE = preload("res://scenes/fighter.tscn")
const CUSTOM_BOT_SCENE = preload("res://scenes/bots/custom_bot.tscn")
const PLAYER_BOT_SCENE = preload("res://scenes/bots/player_custom_bot.tscn")

const TIME_SCENE = preload("res://scenes/ui/game_speed.tscn")
const START_TIMER = preload("res://scenes/ui/321_go.tscn")

var bot_types = []
var player_def = null
var alive_bots = 0

func _ready():
	add_sound()
	initialize_bots(BOT_SCENE)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())

func add_sound():
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = load("res://res/sounds/background_theme_1.mp3")
	audioPlayer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(audioPlayer)
	audioPlayer.play()
	

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
	
	alive_bots = 0
	#create new bots
	for i in range(bot_types.size()):
		spawn_bot(bot_types[i], starting_positions[i + (1 if player_def != null else 0)].global_position)
	
	#add player bot
	if (player_def != null):
		var player_bot = PLAYER_BOT_SCENE.instantiate()
		player_bot.set_bot_definition(player_def)
		
		player_bot.set_color()
		player_bot.health = Progress.player_health
		player_bot.global_position = starting_positions[0].global_position
		player_bot.died.connect(player_died)
		add_child(player_bot)


func spawn_bot(bot_definition, position:Vector2):
	var bot_def = load(bot_definition)
		
	var bot = null
	if (bot_def is BotDefinition):
		bot = CUSTOM_BOT_SCENE.instantiate()
		bot.set_bot_definition(bot_def)
	else:
		bot = BOT_SCENE.instantiate()
		bot.set_controller(bot_def)
		
	bot.set_color()
	bot.global_position = position 
	bot.died.connect(bot_died)
	
	alive_bots += 1
	add_child(bot)

#ächeck for wall collision
func is_possible_spawn_position(position:Vector2) -> bool:
	var map_position = $playing_field.local_to_map($playing_field.to_local(position))
	var tiledata = $playing_field.get_cell_tile_data(map_position)
	return (tiledata != null) and (tiledata.get_collision_polygons_count(0) == 0)
