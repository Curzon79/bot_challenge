extends Node2D


func _on_menu_pressed() -> void:
	var scene = load("res://scenes/menu_game.tscn").instantiate()
	get_tree().root.add_child(scene)
	get_node("/root/win").queue_free()
