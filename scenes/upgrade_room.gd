extends Node2D

const DEFAULT_BOT = "res://scenes/controller/default_bot.gd"

func _ready() -> void:
	$AnimationPlayer.play("appear")
	$BotBuilder.set_current_definition(Progress.player_character)

func start_game():
	var room = Progress.get_next_room()
	var enemies = Progress.get_enemy_set(room)
	
	#do click sound
	$AudioStreamPlayer.play()
	
	#prepare battle: room + bots
	var scene = load(room["scene"]).instantiate()
	var bots = []
	for enemy in enemies:
		bots.append(enemy)
	
	Progress.player_character = $BotBuilder.update_bot_definition()
	scene.set_bots(bots, Progress.player_character)
	
	#replace scene
	get_tree().root.add_child(scene)
	get_node("/root/upgrade").queue_free()
	
