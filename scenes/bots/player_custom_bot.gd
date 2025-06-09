extends "res://scenes/bots/custom_bot.gd"

var radar : Node2D

func _ready() -> void:
	weapon_cooldowns = [$cooldown, $cooldown2, $cooldown3]
	update_health_indication()
	radar = $Radar
