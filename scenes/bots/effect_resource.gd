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
var rank = 1
const Prefixes = {
	"low" : ["Buggy", "Junkyard", "Improvised"],
	"med" : ["Basic", "Industry standard", "Solid"],
	"hi" : ["High performance", "Professional", "Military grade"],
}

func matches_type(other):
	return false

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

func get_description(): 
	return ""

func get_full_description() -> String:
	var full_description = get_description() + "\n"
	for key in modifier.keys():
		var effective_modifier = (modifier[key] * 100 - 100.0)
		if (key == BotDefinition.Hook.MOD_RECEIVE_DAMAGE): effective_modifier *= -1		#Armor is inverse -> lower is better
		if (key == BotDefinition.Hook.MOD_FREQUENCY): effective_modifier *= -1		#Armor is inverse -> lower is better
		if (effective_modifier > 0):
			full_description += "{key} : +{value}%\n".format({"key":BotDefinition.HookNames[key], "value": effective_modifier})
		else:
			full_description += "{key} : {value}%\n".format({"key":BotDefinition.HookNames[key], "value": effective_modifier})
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
