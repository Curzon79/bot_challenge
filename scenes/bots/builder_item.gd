extends Panel

@export var item:Resource

signal selected(node:Node)

func _ready() -> void:
	set_item(item)
	
func set_item(item):
	if (item == null):
		return
		
	self.item = item
	$Icon.texture = item.icon
	$Label.text = item.get_item_name()
	$Icon.tooltip_text = item.get_full_description()
	$Rank.value = item.rank

func set_highlight(highlight: bool):
	if (highlight):
		$selcted.visible = true
		#modulate = Color.YELLOW
	else:
		$selcted.visible = false
		#modulate = Color.WHITE

func _get_drag_data(_pos):
	# Use another rext as drag preview.
	var cpb = TextureRect.new()
	cpb.texture = item.icon
	cpb.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	cpb.size = Vector2(50.0, 50.0)

	# Allows us to center the rect  on the mouse
	var preview = Control.new()
	preview.add_child(cpb)
	cpb.position = -0.5 * cpb.size

	# Sets what the user will see they are dragging
	set_drag_preview(preview)

	# Return color as drag data.
	return item


func _on_icon_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.pressed):
		emit_signal("selected", self)
		
	
