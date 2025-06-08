extends "res://scenes/rooms/room.gd"

const BOT_BUNNY_SCENE = preload("res://scenes/fighter_bunny.tscn")

func _ready():
	default_bot_scene = BOT_BUNNY_SCENE	
	initialize_bots()
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())
