extends "res://scenes/bots/custom_bot.gd"

var radar : Node2D

func _ready() -> void:
	weapon_cooldowns = [$cooldown, $cooldown2, $cooldown3]
	update_health_indication()
	
	radar = $Radar
	var vision_range = bot_definition.get_modifier(self, BotDefinition.Hook.MOD_VISION, BotController.BASE_VISION)
	$Radar.scale = Vector2(vision_range, vision_range) / 500
