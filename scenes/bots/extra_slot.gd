extends EffectResource

class_name ExtraSlots


#Structure
@export var slot_type: BotDefinition.SLOT_TYPE = BotDefinition.SLOT_TYPE.Weapon


func get_description() -> String:
	return "Adds a slot of type: {slot}" \
			.format({"slot" : BotDefinition.SLOT_TYPE.keys()[slot_type]})
