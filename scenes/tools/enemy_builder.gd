extends Control

var enemy_bot_definition = null

func _ready() -> void:
	enemy_bot_definition = BotDefinition.new()
	enemy_bot_definition.hull = Hull.new()


func _on_save() -> void:
	if ($Name.text == ""): 
		return
		
	enemy_bot_definition.color = $Hull/ColorPickerButton.color
		
	enemy_bot_definition.hull.name = $Name.text
	enemy_bot_definition.hull.health = $Hull/Health.value
	enemy_bot_definition.hull.speed = $Hull/Speed.value
	enemy_bot_definition.hull.sprite = load($Hull/Icon.text)
	
	enemy_bot_definition.weapons.clear()
	for weapon in $Weapons.get_children():
		var weapon_res = weapon.get_child(0).get_weapon_resource()
		enemy_bot_definition.weapons.append(weapon_res)

	add_misc(enemy_bot_definition)

	ResourceSaver.save(enemy_bot_definition, $Name.text + ".tres")

func add_misc(bot_definition):
	bot_definition.improvements.clear()
	
	# Vision
	var visionModule =  EffectResource.new()
	visionModule.modifier[BotDefinition.Hook.MOD_VISION] = $Misc/vision.value / BotController.BASE_VISION
	bot_definition.improvements.append(visionModule)
	
	#Aim
	if ($Misc/aim_check.button_pressed):
		var aimModule =  CPU_Aim_Module.new()
		aimModule.modifier[BotDefinition.Hook.MOD_AIM] = $Misc/aim.value
		bot_definition.cpus.append(aimModule)
		
	#move enemy
	if ($Misc/range_enemy_check.button_pressed):
		var enemyMoveModule =  CPU_Move_Module.new()
		enemyMoveModule.target = CPU_Move_Module.Target.ENEMY
		enemyMoveModule.target_distance = $Misc/range_enemy.value
		bot_definition.cpus.append(enemyMoveModule)
		
	#move wall
	if ($Misc/range_wall_check.button_pressed):
		var wallMoveModule =  CPU_Move_Module.new()
		wallMoveModule.target = CPU_Move_Module.Target.WALLS
		wallMoveModule.target_distance = $Misc/range_wall.value
		bot_definition.improvements.append(wallMoveModule)



func _on_add_weapon_pressed() -> void:
	var newTab = TabBar.new()
	var weaponsBuilder = load("res://scenes/tools/weapon_builder.tscn").instantiate()
	weaponsBuilder.position = Vector2(24, 17)
	weaponsBuilder.size = Vector2(336, 216)
	newTab.add_child(weaponsBuilder)
	newTab.name = "Weapon %d" % ($Weapons.get_child_count() + 1)	
	$Weapons.add_child(newTab)


func _on_delete_weapon_pressed() -> void:
	$Weapons.get_current_tab_control().queue_free()
