extends "res://scenes/rooms/room.gd"

const BOT_BUNNY_SCENE = preload("res://scenes/fighter_bunny.tscn")
const START_GAME_TIME = preload("res://scenes/ui/game_time.tscn")



func _ready():
	default_bot_scene = BOT_BUNNY_SCENE
	initialize_bots()
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())
	add_child(START_GAME_TIME.instantiate())
	
	#connect
	get_node("fighter_bunny").died.connect(player_died)

func player_died():
	$game_time.stop()
