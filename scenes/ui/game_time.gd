extends Node2D


var time = 0
var running = true

func _process(delta: float) -> void:
	if (!running):
		return
		
	time += delta
	$Panel/time.text = "%2.2f s" % time

func stop():
	running = false
