extends "res://scenes/rooms/room.gd"

const BOT_BUNNY_SCENE = preload("res://scenes/fighter_bunny.tscn")

func _ready():
	initialize_bots(BOT_BUNNY_SCENE)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())
