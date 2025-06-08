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
	
	enemy_bot_definition.weapons.clear()
	for weapon in $Weapons.get_children():
		var weapon_res = weapon.get_child(0).get_weapon_resource()
		enemy_bot_definition.weapons.append(weapon_res)

	ResourceSaver.save(enemy_bot_definition, $Name.text + ".tres")



func _on_add_weapon_pressed() -> void:
	var newTab = TabBar.new()
	var weaponsBuilder = load("res://scenes/tools/weapon_builder.tscn").instantiate()
	weaponsBuilder.position = Vector2(24, 17)
	weaponsBuilder.size = Vector2(336, 216)
	newTab.add_child(weaponsBuilder)
	newTab.name = "Weapon %d" % ($Weapons.get_child_count() + 1)	
	$Weapons.add_child(newTab)
