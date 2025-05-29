extends "res://scenes/rooms/room.gd"

const BOT_TURRET = preload("res://scenes/fighter_turret.tscn")
const BOT_BUNNY = preload("res://scenes/fighter_bunny.tscn")
const START_BUNNY_COUNT = preload("res://scenes/ui/bunny_count.tscn")


@export var spawn_bot_type:Script

func _ready():
	initialize_bots(BOT_TURRET)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())
	add_child(START_BUNNY_COUNT.instantiate())


func _on_timer_timeout() -> void:
	#create new bot
	var bot = BOT_BUNNY.instantiate()
	bot.set_controller(spawn_bot_type)
	bot.set_color()
	bot.global_position = Vector2(randf() * 1000 + 100, randf() * 400 + 100)

	add_child(bot)
