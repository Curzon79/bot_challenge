extends Resource

class_name BotDefinition

enum SLOT_TYPE {Weapon, Improvement, Cpu}

@export var color = Color.WHITE
@export var hull: Hull

@export var weapons: Array[Weapon]
@export var improvements: Array[EffectResource] #Can be anythig really
@export var cpus: Array[EffectResource]

#extra slots: weapon, improvement, cpu
@export var extra_slots = {
	SLOT_TYPE.Weapon: 0,
	SLOT_TYPE.Improvement: 0,
	SLOT_TYPE.Cpu: 0,
}

enum Hook {
		ACT 			= 0, 
		AIM 			= 1, 
		MOVE 			= 2, 
		MOVE_PRIO 		= 3, 
		PRE_PROCCESS 	= 4,
		POST_PROCESS 	= 5,
		
		MOD_SPEED  			= 10,
		MOD_FREQUENCY 		= 11, 
		MOD_VISION  		= 12,
		MOD_RECEIVE_DAMAGE 	= 13,
		MOD_DEAL_DAMAGE		= 14,
		MOD_AIM				= 15,
		MOD_REPAIR			= 16,
		}

const HookNames = {
	Hook.MOD_SPEED: "Speed",
	Hook.MOD_FREQUENCY: "Shoot rate", 
	Hook.MOD_VISION: "Vision",
	Hook.MOD_RECEIVE_DAMAGE: "Resistance",
	Hook.MOD_DEAL_DAMAGE: "Damage",
	Hook.MOD_AIM: "Precision",
	Hook.MOD_REPAIR: "Repair",
}

var modifiers = [
	Hook.MOD_SPEED,
	Hook.MOD_FREQUENCY,
	Hook.MOD_VISION,
	Hook.MOD_RECEIVE_DAMAGE,
	Hook.MOD_DEAL_DAMAGE,
	Hook.MOD_AIM,
	Hook.MOD_REPAIR,
]

var hooks = {
	Hook.ACT:[], 
	Hook.AIM:[], 
	Hook.MOVE:[],
	Hook.MOVE_PRIO:[],
	Hook.PRE_PROCCESS:[],
	Hook.POST_PROCESS:[],
	Hook.MOD_SPEED:[],
	Hook.MOD_FREQUENCY:[],
	Hook.MOD_VISION:[],
	Hook.MOD_RECEIVE_DAMAGE:[],
	Hook.MOD_DEAL_DAMAGE:[],
	Hook.MOD_AIM:[],
	Hook.MOD_REPAIR:[]
}

func add_slot(type: SLOT_TYPE) -> void:
	extra_slots[type] += 1

func get_slots(type: SLOT_TYPE) -> int:
	match type: 
		SLOT_TYPE.Weapon:
			return hull.weapon_slots + extra_slots[type]
		SLOT_TYPE.Improvement:
			return hull.improvement_slots + extra_slots[type]
		SLOT_TYPE.Cpu:
			return hull.cpu_slots + extra_slots[type]
	return 0

func update():
	hooks = {
	Hook.ACT:[], 
	Hook.AIM:[], 
	Hook.MOVE:[],
	Hook.MOVE_PRIO:[],
	Hook.PRE_PROCCESS:[],
	Hook.POST_PROCESS:[],
	Hook.MOD_SPEED:[],
	Hook.MOD_FREQUENCY:[],
	Hook.MOD_VISION:[],
	Hook.MOD_RECEIVE_DAMAGE:[],
	Hook.MOD_DEAL_DAMAGE:[],
	Hook.MOD_AIM:[],
	Hook.MOD_REPAIR:[]
	}
	#determine hooks
	for cpu_module in cpus:
		update_hooks_for_module(cpu_module)

	for improvement in improvements:
		update_hooks_for_module(improvement)

func update_hooks_for_module(module):
	if (module.has_method("call_aim")):
		hooks[Hook.AIM].append(module)

	if (module.has_method("call_move")):
		hooks[Hook.MOVE].append(module)

	if (module.has_method("call_move_prio")):
		hooks[Hook.MOVE_PRIO].append(module)
	
	if (module.has_method("call_post_process")):
		hooks[Hook.POST_PROCESS].append(module)
	
	if (! module.has_method("does_modify")):
		return
		
	for modifier in modifiers:
		if (module.does_modify(modifier)):
			hooks[modifier].append(module)
	
func call_aim(bot:CustomBot, targets, vision_all):
	if (len(hooks[Hook.AIM]) == 0):
		return Aim.new(get_random_direction(), 1.0)
	
	var aim = null
	for hook in hooks[Hook.AIM]:
		if (aim == null):
			aim = hook.call_aim(bot, targets, vision_all)
		else:
			aim = aim.merge(hook.call_aim(bot, targets,vision_all))
	return aim

func call_move(bot:CustomBot, current_direction:Vector2):
	if (len(hooks[Hook.MOVE]) == 0):
		return null
	
	var force = Vector2()
	for hook in hooks[Hook.MOVE]:
		force = force + hook.call_move(bot)
	
	#var direction = get_random_direction()
	var direction = force.normalized()
	
	if (direction == Vector2()):
		direction = get_random_direction()
	
	
	return Command.new(Command.MOVE, (current_direction + direction * 0.25).normalized())
	

func call_move_prio(bot:CustomBot):
	if (len(hooks[Hook.MOVE_PRIO]) == 0):
		return null
		
	return hooks[Hook.MOVE_PRIO][0].call_move_prio(bot)


func call_post_process(bot:CustomBot, delta:float):
	for hook in hooks[Hook.POST_PROCESS]:
		hook.call_post_process(bot, delta)


func shoot_weapon(command:Command, bot:CustomBot, weapon_slot:int):
	weapons[weapon_slot].shoot_weapon(command, bot)


func get_shoot_frequency(bot:CustomBot, weapon_slot: int):
	var frequency = weapons[weapon_slot].get_frequency()
	for hook in hooks[Hook.MOD_FREQUENCY]:
		frequency = hook.modify(bot, Hook.MOD_FREQUENCY, frequency) 
	return frequency

func get_speed(bot:CustomBot):
	var speed = hull.speed
	for hook in hooks[Hook.MOD_SPEED]:
		speed = hook.modify(bot, Hook.MOD_SPEED, speed) 
	return speed
	
func get_modifier(bot:CustomBot, modifier_type: Hook, value: float):
	for hook in hooks[modifier_type]:
		value = hook.modify(bot, modifier_type, value) 
	return value
	
func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
