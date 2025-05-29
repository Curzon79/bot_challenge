extends TextureRect

@export var item:Resource

func _ready() -> void:
	self.texture = item.icon
	$Label.text = item.name

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
