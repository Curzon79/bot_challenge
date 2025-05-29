extends Resource

class_name BotDefinition

@export var hull: Hull

@export var weapons: Array[Weapon]
@export var improvements: Array[Improvement]
@export var cpus: Array[CPU_Module]

enum Hook {
		ACT, 
		AIM, 
		MOVE, 
		MOVE_PRIO, 
		PRE_PROCCESS,
		POST_PROCESS,
		MOD_SPEED,
		MOD_FREQUENCY}

var modifiers = [
	Hook.MOD_SPEED,
	Hook.MOD_FREQUENCY
]

var hooks = {
	Hook.ACT:[], 
	Hook.AIM:[], 
	Hook.MOVE:[],
	Hook.MOVE_PRIO:[],
	Hook.PRE_PROCCESS:[],
	Hook.POST_PROCESS:[],
	Hook.MOD_SPEED:[],
	Hook.MOD_FREQUENCY:[]
}

func update():
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
	
	if (! module.has_method("does_modify")):
		return
		
	for modifier in modifiers:
		if (module.does_modify(modifier)):
			hooks[modifier].append(module)
	
func call_aim(bot:CustomBot, targets):
	if (len(hooks[Hook.AIM]) == 0):
		return get_random_direction()
		
	return hooks[Hook.AIM][0].call_aim(bot, targets)

func call_move(bot:CustomBot):
	if (len(hooks[Hook.MOVE]) == 0):
		return null
		
	return hooks[Hook.MOVE][0].call_move(bot)

func call_move_prio(bot:CustomBot):
	if (len(hooks[Hook.MOVE_PRIO]) == 0):
		return null
		
	return hooks[Hook.MOVE_PRIO][0].call_move_prio(bot)


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
	
func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
