extends Node2D

var hidden_ = true




func _on_button_pressed() -> void:
	if hidden_:
		$AnimationPlayer.play("slide_in")
		hidden_ = false
	else:
		$AnimationPlayer.play_backwards("slide_in")
		hidden_ = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_pause_pressed() -> void:
	get_tree().paused = true


func _on_play_pressed() -> void:
	get_tree().paused = false



func _on_h_slider_value_changed(value: float) -> void:
	Engine.time_scale = value
