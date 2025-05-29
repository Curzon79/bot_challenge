extends Node2D

const MAX_TIME = 15.0
const main_color = Color.FIREBRICK

func _process(_delta: float) -> void:
	var color = main_color * $Timer.time_left/ MAX_TIME
	modulate = color

func _on_timer_timeout() -> void:
	pass # might not need that


func _on_area_2d_body_entered(_body: Node2D) -> void:
	$Timer.start(MAX_TIME)
