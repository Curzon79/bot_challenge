extends Node2D

const DEFAULT_BOT = "res://scenes/controller/default_bot.gd"

func start_game():
	var room = Progress.get_next_room()
	
	#prepare battle: room + bots
	var scene = load(room["scene"]).instantiate()
	var bots = []
	for i in range(room["positions"] - 1):
		bots.append(DEFAULT_BOT)
	
	Progress.player_character = $BotBuilder.get_bot_definition()
	scene.set_bots(bots, Progress.player_character)
	
	#replace scene
	get_tree().root.add_child(scene)
	get_node("/root/upgrade").queue_free()
	
