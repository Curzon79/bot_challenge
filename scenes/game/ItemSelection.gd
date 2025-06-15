extends Object

class_name ItemSelection


const Items = {
	"common": [
		"res://scenes/bots/parts/cpu_t1_aim_forward.tres",
		"res://scenes/bots/parts/cpu_t1_aim_med.tres",
		"res://scenes/bots/parts/cpu_t1_aim_sweep.tres",
		"res://scenes/bots/parts/cpu_t1_aim_weak.tres",
		"res://scenes/bots/parts/cpu_t1_move_avoid_walls.tres",
		"res://scenes/bots/parts/cpu_t1_move_from_enemy.tres",
		"res://scenes/bots/parts/cpu_t1_move_to_enemy_avg.tres",
		"res://scenes/bots/parts/cpu_t1_move_to_enemy_close.tres",
		"res://scenes/bots/parts/weapon_t1_big_cannon.tres", 
		"res://scenes/bots/parts/weapon_t1_bomb.tres", 
		"res://scenes/bots/parts/weapon_t1_cannon.tres", 
		"res://scenes/bots/parts/weapon_t1_laser.tres", 
		"res://scenes/bots/parts/weapon_t1_pea_shooter.tres", 
		"res://scenes/bots/parts/weapon_t1_shocker.tres",
		"res://scenes/bots/parts/imp_t1_condensator.tres", 
		"res://scenes/bots/parts/imp_t1_condensator_2.tres", 
		"res://scenes/bots/parts/imp_t1_engine.tres", 
		"res://scenes/bots/parts/imp_t1_optics_1.tres", 
		"res://scenes/bots/parts/imp_t1_ram_1.tres", 
		"res://scenes/bots/parts/imp_t1_ram_2.tres", 
		"res://scenes/bots/parts/imp_t1_repair_1.tres"
	],
	"uncommon":[
		"res://scenes/bots/parts/weapon_t2_big_cannon.tres",
		"res://scenes/bots/parts/weapon_t2_bomb.tres",
		"res://scenes/bots/parts/weapon_t2_cannon_fast.tres",
		"res://scenes/bots/parts/weapon_t2_laser.tres",
		"res://scenes/bots/parts/weapon_t2_shocker.tres",
		"res://scenes/bots/parts/imp_t1_repair_2.tres",
		"res://scenes/bots/parts/imp_t1_optics_2.tres", 
		"res://scenes/bots/parts/cpu_t1_aim_no_walls.tres",	
		
	],
	"rare":[
		"res://scenes/bots/parts/cpu_t2_aim_perfect.tres",
		"res://scenes/bots/parts/weapon_t3_bomb.tres", 
		"res://scenes/bots/parts/weapon_t3_laser.tres", 
		"res://scenes/bots/parts/weapon_t3_shocker.tres"
	]
}

const Additions = {
	"low" : [
		"res://scenes/bots/parts/additions/slow_move_t1_.tres",
		"res://scenes/bots/parts/additions/slow_shooting_t1.tres"
	],
	"med" : [
		"res://scenes/bots/parts/additions/slow_move_t2.tres",
		"res://scenes/bots/parts/additions/slow_shooting_t2.tres"
	],
	"hi" : [
		"res://scenes/bots/parts/additions/slow_move_t3.tres",
		"res://scenes/bots/parts/additions/slow_shooting_t3.tres"
	]
}

const Ranks = [
	0.2,		# Rank 5
	1.5, 		# Rank 4
	8.0, 		# Rank 3
	20.0, 		# Rank 2
]

const RankOptions = {
	1: [["common", "low"]],
	2: [["common", "med"], ["uncommon", "low"]],
	3: [["common", "hi"], ["uncommon", "med"], ["rare", "low"]],
	4: [["uncommon", "hi"], ["rare", "med"]],
	5: [["rare", "hi"]],
}

func get_item_Selection(amount:int = 0) -> Array:
	var items = []
	
	for i in range(amount):
		items.append(get_random_item())
	
	return items

func get_random_item():
	#determine rank
	var rank_number = randf() * 100.0
	var rank = 5
	for rank_threshold in Ranks:
		rank_number = rank_number - rank_threshold
		if (rank_number < 0):
			break
		rank = rank - 1
	var option = RankOptions[rank].pick_random()
	var item = Items[option[0]].pick_random()
	var addition = Additions[option[1]].pick_random()
	return item.merge(addition)
