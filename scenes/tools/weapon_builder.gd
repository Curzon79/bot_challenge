extends Panel


func get_weapon_resource():
	var weapon = null
	match $WeaponType.selected:
		0:
			weapon = Weapon.new()
		1:
			weapon = WeaponLaser.new()
			weapon.duration = $Laser/Duration.value
			weapon.sweep = $Laser/Sweep.value
		2:
			weapon = WeaponBomb.new()
			weapon.time = $Bomb/Time.value
		3: 
			weapon = WeaponSpawn.new()
			weapon.spawn_bot = $Spawn/spawnType.text

	weapon.damage = $Damage.value
	weapon.base_frequency = $Frequency.value
	
	return weapon

func _on_weapon_type_item_selected(index: int) -> void:
	$Laser.visible = index == 1
	$Bomb.visible = index == 2
	$Spawn.visible = index == 3
