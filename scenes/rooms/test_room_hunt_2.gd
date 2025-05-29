extends "res://scenes/rooms/room.gd"

const BOT_TURRET = preload("res://scenes/fighter_turret.tscn")
const BOT_BUNNY = preload("res://scenes/fighter_bunny.tscn")
const START_BUNNY_TIME = preload("res://scenes/ui/bunny_time.tscn")


@export var spawn_bot_type:Script

var times = []
var current_time = 0.0

func _ready():
	initialize_bots(BOT_TURRET)
	add_child(TIME_SCENE.instantiate())
	add_child(START_TIMER.instantiate())
	
	new_bunny()

func _process(delta: float) -> void:
	current_time += delta

func bunny_died():
	times.append(current_time)
	current_time = 0
	new_bunny()

func new_bunny() -> void:
	#create new bot
	var bot = BOT_BUNNY.instantiate()
	bot.set_controller(spawn_bot_type)
	bot.set_color()
	bot.global_position = Vector2(randf() * 1000 + 100, randf() * 400 + 100)
	bot.died.connect(bunny_died)
	call_deferred("add_child", bot)

func get_average_time():
	var avg = current_time
	for t in times:
		avg += t

	return avg /(len(times) + 1)
