extends Resource

class_name EffectResource


#Structure
@export var cost = 100

@export var modifier:Dictionary[BotDefinition.Hook, float] = {}

#Representation
@export var name: String
@export var icon: Texture2D
@export var sprite: Texture2D


func does_modify(type):
	return modifier.has(type)
	
func modify(bot: CustomBot, type:BotDefinition.Hook, value):
	if (!modifier.has(type)):
		return value
	return value * modifier[type]

func merge(other:EffectResource) -> void:
	modifier.merge(other.modifier, false)
