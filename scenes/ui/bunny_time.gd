extends Node2D

var room = null

func _ready() -> void:
	room = get_parent()
	
func _process(delta: float) -> void:
	var average_time = room.get_average_time()
	$Panel/time.text = "%2.2f s" % average_time
