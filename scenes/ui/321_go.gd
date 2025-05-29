extends Node2D

func _ready() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("game_start")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().paused = false
	queue_free()
