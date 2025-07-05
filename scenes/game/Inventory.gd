extends Object

class_name Inventory

var weapons: Array[Weapon]
var improvements: Array[Improvement]
var cpus: Array[CPU_Module]


func _init() -> void:
	weapons = [
		#load("res://scenes/bots/parts/weapon_t1_cannon.tres"), 
		#load("res://scenes/bots/parts/weapon_t1_laser.tres"), 
		#load("res://scenes/bots/parts/weapon_t2_cannon_fast.tres"),
		#load("res://scenes/bots/parts/weapon_t2_laser.tres"),
		#load("res://scenes/bots/parts/weapon_t3_laser.tres"),
		#load("res://scenes/bots/parts/weapon_t1_bomb.tres"),
		#load("res://scenes/bots/parts/weapon_t2_bomb.tres"),
		#load("res://scenes/bots/parts/weapon_t1_pea_shooter.tres"),
		#load("res://scenes/bots/parts/weapon_t3_bomb.tres"),
		#load("res://scenes/bots/parts/weapon_t1_big_cannon.tres"),
		#load("res://scenes/bots/parts/weapon_t2_big_cannon.tres"),
		#load("res://scenes/bots/parts/weapon_t1_shocker.tres"),
		#load("res://scenes/bots/parts/weapon_t2_shocker.tres"),
		#load("res://scenes/bots/parts/weapon_t3_shocker.tres"),
		]
	improvements = [
		#load("res://scenes/bots/parts/imp_t1_engine.tres"), 
		#load("res://scenes/bots/parts/imp_t1_brittler.tres"), 
		#load("res://scenes/bots/parts/imp_t1_optics_1.tres"), 
		#load("res://scenes/bots/parts/imp_t1_optics_2.tres"),
		#load("res://scenes/bots/parts/imp_t1_repair_1.tres"), 
		#load("res://scenes/bots/parts/imp_t2_repair_2.tres"),
		#load("res://scenes/bots/parts/imp_t1_ram_1.tres"),
		#load("res://scenes/bots/parts/imp_t1_condensator.tres"),
		#load("res://scenes/bots/parts/imp_t1_condensator_2.tres"),
		]
	cpus = [
		#load("res://scenes/bots/parts/cpu_t1_aim_weak.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_aim_med.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_aim_sweep.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_aim_forward.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_aim_no_walls.tres"), 
		#load("res://scenes/bots/parts/cpu_t2_aim_perfect.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_move_from_enemy.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_move_to_enemy_avg.tres"), 
		#load("res://scenes/bots/parts/cpu_t1_move_to_enemy_close.tres"),
		#load("res://scenes/bots/parts/cpu_t1_move_avoid_walls.tres"),
		]	

func add(item:Resource):
	if (item is Weapon):
		weapons.append(item)
		
	if (item is Improvement):
		improvements.append(item)

	if (item is CPU_Module):
		cpus.append(item)
		
