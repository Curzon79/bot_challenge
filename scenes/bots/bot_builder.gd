extends Control

const SLOT_SCENE = preload("res://scenes/bots/builder_slot.tscn")
const ITEM_SCENE = preload("res://scenes/bots/builder_item.tscn")

var bot_definition = BotDefinition.new()

func _ready():
	set_hull(load("res://scenes/bots/parts/hull_t1_std.tres"))
	
	fill_inventory()
	
func set_hull(hull:Hull):
	bot_definition.hull = hull
	$Bot/Hull.texture = hull.icon
	
	add_slots(hull.cpu_slots, $Bot/Cpu, BuilderSlot.Type.CPU_Module)
	add_slots(hull.improvement_slots, $Bot/Improvements, BuilderSlot.Type.Improvement)
	add_slots(hull.weapon_slots, $Bot/Weapons,BuilderSlot.Type.Weapon)
	

func add_slots(amount:int, control:Control, type:BuilderSlot.Type ):
	for child in control.get_children():
		control.remove_child(child)
		child.queue_free()
		
	for i in range(amount):
		var slot = SLOT_SCENE.instantiate()
		slot.type = type
		control.add_child(slot)
		slot.dropped.connect(item_dropped)

func fill_inventory():
	for weapon in Progress.player_inventory.weapons:
		add_item($Inventory/Weapons/VBoxContainer, weapon)

	for improvement in Progress.player_inventory.improvements:
		add_item($Inventory/Improvements/VBoxContainer, improvement)

	for cpu_module in Progress.player_inventory.cpus:
		add_item($"Inventory/Cpu/VBoxContainer", cpu_module)
		

func add_item(control:Control, item:Resource):
		var item_box = ITEM_SCENE.instantiate()
		item_box.item = item
		control.add_child(item_box)
		
func remove_item(control:Control, item:Resource):
		for child in control.get_children():
			if (child.item == item):
				control.remove_child(child)
		
func item_dropped(item:Resource, replaced_item:Resource):
	var control = $Inventory/Weapons/VBoxContainer
	if (item is Improvement):
		control = $Inventory/Improvements/VBoxContainer
	if (item is CPU_Module): 
		control = $Inventory/Cpu/VBoxContainer
		
	if (replaced_item != null):
		add_item(control, replaced_item)
	
	remove_item(control, item)

func set_current_definition(bot_definition:BotDefinition):
	for i in bot_definition.weapons.size():
		remove_item($Inventory/Weapons/VBoxContainer, bot_definition.weapons[i])
		$Bot/Weapons.get_child(i).set_item(bot_definition.weapons[i])

	for i in bot_definition.improvements.size():
		remove_item($Inventory/Improvements/VBoxContainer, bot_definition.improvements[i])
		$Bot/Improvements.get_child(i).set_item(bot_definition.improvements[i])

	for i in bot_definition.cpus.size():
		remove_item($Inventory/Cpu/VBoxContainer, bot_definition.cpus[i])
		$Bot/Cpu.get_child(i).set_item(bot_definition.cpus[i])

func get_bot_definition():
	for weapon in $Bot/Weapons.get_children():
		if (weapon.item):
			bot_definition.weapons.append(weapon.item)
	for cpu  in $Bot/Cpu.get_children():
		if (cpu.item):
			bot_definition.cpus.append(cpu.item)
	for improvement in $Bot/Improvements.get_children():
		if (improvement.item):
			bot_definition.improvements.append(improvement.item)
	bot_definition.update()
	
	return bot_definition
