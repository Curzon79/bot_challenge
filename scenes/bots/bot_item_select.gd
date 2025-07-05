extends Panel

var selected_item = null

signal closed
	
func _ready():
	$AnimationPlayer.play("appear")
	get_tree().paused = true
	
func set_items(tier:float):
	var item_fields = [$Item1, $Item2, $Item3]
	var items = ItemSelection.get_item_Selection(3)
	var i = 0 
	for item in items:
		item_fields[i].set_item(item)
		i += 1
		

func _on_button_pressed() -> void:
	get_tree().paused = false
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
	
