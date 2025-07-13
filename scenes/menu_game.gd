extends Node2D

const DEFAULT_BOT = "res://scenes/controller/default_bot.gd"

func _ready() -> void:
	$menu.visible = true


func start_game():
	#do click sound
	$Click.play()
	
	$menu/start.visible = false
	var item_select = load("res://scenes/bots/bot_item_select.tscn").instantiate()
	item_select.set_items(1.0)
	add_child(item_select)
	
	item_select.closed.connect(start_next_level)

func start_next_level():
	var scene = load("res://scenes/upgrade_room.tscn").instantiate()
	get_tree().root.add_child(scene)
	get_node("/root/menu").queue_free()
	
