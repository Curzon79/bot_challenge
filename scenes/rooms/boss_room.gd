extends "res://scenes/rooms/room.gd"

func next_level():
	
	var win_scene = load("res://scenes/win.tscn").instantiate()
	get_tree().root.add_child(win_scene)
	get_node("/root/boss_room").queue_free()
