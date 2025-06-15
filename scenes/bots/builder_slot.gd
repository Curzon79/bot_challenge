extends Panel

class_name BuilderSlot

enum Type {Improvement, Weapon, CPU_Module} 
@export var type = Type.Improvement

var item: Resource

signal dropped

func _can_drop_data(_pos, data):
	match type:
		Type.Improvement:
			return data is Improvement
		Type.Weapon:
			return data is Weapon
		Type.CPU_Module:
			return data is CPU_Module
	
func _drop_data(_pos, data):
	emit_signal("dropped", data, item)
	set_item(data)


func set_item(item):
	self.item = item
	$Texture.texture = item.icon
	$Texture.tooltip_text = item.get_full_description()
