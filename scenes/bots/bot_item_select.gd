extends Panel

var selected_item = null

signal closed
	
func _ready():
	pass
	
func set_items(tier:float):
	var item_fields = [$Item1, $Item2, $Item3]
	for i in range(3):
		var item = choose_item(tier)
		item_fields[i].set_item(item)
		
func choose_item(tier:float):
	var items = Globals.UPGRADES["t1"]
	return load(items.pick_random())


func _on_button_pressed() -> void:
	if (selected_item):
		if (selected_item.item is ExtraSlots):
			Progress.player_character.add_slot(selected_item.item.slot_type)
		else:
			Progress.player_inventory.add(selected_item.item)
	emit_signal("closed")

func _on_item_selected(node: Node) -> void:
	if (selected_item):
		selected_item.set_highlight(false)
	
	selected_item = node
	node.set_highlight(true)
	
