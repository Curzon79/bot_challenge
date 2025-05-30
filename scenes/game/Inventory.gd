extends Object

class_name Inventory

var weapons: Array[Weapon]
var improvements: Array[Improvement]
var cpus: Array[CPU_Module]

func _init() -> void:
	weapons = [
		load("res://scenes/bots/parts/weapon_t1_cannon.tres"), 
		load("res://scenes/bots/parts/weapon_t1_laser.tres"), 
		load("res://scenes/bots/parts/weapon_t2_cannon_fast.tres"),
		]
	improvements = [
		load("res://scenes/bots/parts/imp_t1_engine.tres"), 
		]
	cpus = [
		load("res://scenes/bots/parts/cpu_t1_aim_weak.tres"), 
		load("res://scenes/bots/parts/cpu_t1_aim_med.tres"), 
		load("res://scenes/bots/parts/cpu_t2_aim_perfect.tres"), 
		load("res://scenes/bots/parts/cpu_t1_move_from_enemy.tres"), 
		load("res://scenes/bots/parts/cpu_t1_move_to_enemy_avg.tres"), 
		load("res://scenes/bots/parts/cpu_t1_move_to_enemy_close.tres"),
		load("res://scenes/bots/parts/cpu_t1_move_to_enemy_avg.tres"),
		]	

func add(item:Resource):
	if (item is Weapon):
		weapons.append(item)
		
	if (item is Improvement):
		improvements.append(item)

	if (item is CPU_Module):
		cpus.append(item)
		
