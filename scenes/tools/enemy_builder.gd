extends Control

var enemy_bot_definition = null

func _ready() -> void:
	enemy_bot_definition = BotDefinition.new()
	enemy_bot_definition.hull = Hull.new()


func _on_save() -> void:
	if ($Name.text == ""): 
		return
		
	enemy_bot_definition.hull.name = $Name.text
	enemy_bot_definition.hull.health = $Hull/Health.value
	enemy_bot_definition.hull.speed = $Hull/Speed.value

	ResourceSaver.save(enemy_bot_definition, $Name.text + ".tres", 
		 )
