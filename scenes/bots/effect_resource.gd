extends Resource

class_name EffectResource


#Structure
@export var cost = 100

@export var modifier:Dictionary[BotDefinition.Hook, float] = {}

#Representation
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var sprite: Texture2D

var merge_type = null
const Prefixes = {
	"low" : ["Buggy", "Junkyard", "Homemade"],
	"med" : ["Basic", "Industry standard", "Solid"],
	"hi" : ["High performance", "Professional", "Military grade"],
}

func does_modify(type):
	return modifier.has(type)
	
func modify(bot: CustomBot, type:BotDefinition.Hook, value):
	if (!modifier.has(type)):
		return value
	return value * modifier[type]

func merge(other:EffectResource, merge_type:String) -> EffectResource:
	self.merge_type = merge_type
	modifier.merge(other.modifier, false)
	return self

func get_base_description(): 
	return ""

func get_description() -> String:
	var full_description = get_base_description()
	
	return full_description

func get_item_name() -> String:
	var index = -1
	if self is CPU_Module: index = 0
	if self is Improvement: index = 1
	if self is Weapon: index = 2
	if (index < 0 or merge_type == null):
		return name
	var prefix = Prefixes[merge_type][index]
	return prefix + " " + name
