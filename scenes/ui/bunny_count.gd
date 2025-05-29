extends Node2D

var room = null
var average_bots = 0
const decay = 0.95

func _ready() -> void:
	room = get_parent()
	
func _process(delta: float) -> void:
	average_bots = average_bots * decay + get_bot_count() * (1.0 - decay)
	$Panel/time.text = "%2.2f" % average_bots

func get_bot_count() -> int:
	var count = 0
	for child in room.get_children():
		if (child is Fighter):
			count += 1
	return count - 1 #we have to deduct ourselves -> always alive
