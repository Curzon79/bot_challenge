extends Node

const PROGRESSION_FACTOR = 1.15
const BOSS_THRESHOLD = 220

const CHALLENGE_ROOMS = [
	{
		"name": "Challenge 1",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_1.tscn",
		"preview": "res://res/room1.png",
		"positions" : 1,
		"selection" : "elite"
	},
	{
		"name": "Challenge 2",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_2.tscn",
		"preview": "res://res/room1.png",
		"positions" : 2
	},
	{
		"name": "Challenge 3",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_3.tscn",
		"preview": "res://res/room1.png",
		"positions" : 3
	},
	{
		"name": "Challenge 4",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_4.tscn",
		"preview": "res://res/room1.png",
		"positions" : 4
	},
	{
		"name": "Challenge 4",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_7.tscn",
		"preview": "res://res/room1.png",
		"positions" : 7,
		"selection": "swarm"
	},	
]

const BOSS_ROOM = {
		"name": "Boss",
		"scene": "res://scenes/rooms/challenge_rooms/boss_room_1.tscn",
		"preview": "res://res/room1.png",
		"positions" : 1,
		"selection": "boss"
	}	

const ENEMIES = {
	PAWN : 10,
	BEE: 20,
	WASP: 35,
	FIGHTER_PEA: 50,
	FIGHTER_LIGHT: 50,
	FIGHTER_STD : 70,
	FIGHTER_HEAVY: 80,
	FIGHTER_VERY_HEAVY: 140,
}

const ELITES = {
	FIGHTER_VERY_HEAVY: 140,
	FIGHTER_SUPER_HEAVY: 250,
}

const BOSSES = [
	FIGHTER_VERY_HEAVY,
	FIGHTER_SUPER_HEAVY,
]


const PAWN = "res://scenes/bots/enemies/pawn.tres"
const BEE = "res://scenes/bots/enemies/bee.tres"
const WASP = "res://scenes/bots/enemies/wasp.tres"
const FIGHTER_HEAVY = "res://scenes/bots/enemies/fighter_heavy.tres"
const FIGHTER_LIGHT = "res://scenes/bots/enemies/fighter_light.tres"
const FIGHTER_PEA = "res://scenes/bots/enemies/fighter_pea.tres"
const FIGHTER_STD = "res://scenes/bots/enemies/fighter_std.tres"
const FIGHTER_VERY_HEAVY = "res://scenes/bots/enemies/fighter_very_heavy.tres"
const FIGHTER_SUPER_HEAVY = "res://scenes/bots/enemies/fighter_super_heavy.tres"

#var rooms : Array = []
var player_character: BotDefinition
var player_health: float
var player_inventory: Inventory

var player_progression = 100

func _init():
	#rooms = CHALLENGE_ROOMS.duplicate()
	
	player_character = BotDefinition.new()
	player_character.color = Color.CORAL
	player_character.hull = load("res://scenes/bots/parts/hull_t1_std.tres")
	player_character.weapons.append(load("res://scenes/bots/parts/weapon_t1_cannon.tres") )
	player_health = player_character.hull.health
	player_inventory = Inventory.new()

func progress_difficulty():
	player_progression *= PROGRESSION_FACTOR

func get_next_room():
	if (player_progression > BOSS_THRESHOLD):
		return BOSS_ROOM
	return CHALLENGE_ROOMS.pick_random()

func get_enemy_set(room:Dictionary):
	if (room.has("selection")):
		if (room["selection"] == "elite"):
			return get_elite_enemy_set()
		if (room["selection"] == "boss"):
			return get_boss_enemy_set()
		elif (room["selection"] == "swarm"):
			return get_swarm_enemy_set(room["positions"])
	var enemy_set = []
	var enemy_set_value = 0
	var enemies = ENEMIES.keys()
	for i in range (room["positions"]):
		var enemy = enemies.pick_random()
		enemy_set.append(enemy)
		enemy_set_value += ENEMIES[enemy]
	
	#try to fix progression
	while (enemy_set_value > player_progression * 1.4 or 
		   enemy_set_value < player_progression * 0.8):
			#pick one
			var enemy = enemy_set.pick_random()
			
			#pick replacement
			var replacement = enemies.pick_random()
			
			#replace if makes the set better
			if ( (ENEMIES[enemy] - ENEMIES[replacement]) * 
				 (enemy_set_value - player_progression) > 0):
				enemy_set_value -= ENEMIES[enemy]
				enemy_set_value += ENEMIES[replacement]
				enemy_set.erase(enemy)
				enemy_set.append(replacement)
					

	return enemy_set


func get_elite_enemy_set():
	return [get_closest_to_value(ELITES, player_progression)]

func get_boss_enemy_set():
	return [BOSSES.pick_random()]
	
func get_swarm_enemy_set(amount: int):
	var enemy = get_closest_to_value(ENEMIES, player_progression / amount)
	var enemies = []
	for i in range(amount):
		enemies.append(enemy)
	return enemies


func get_closest_to_value(elements:Dictionary, value:float):
	var best_dist = 10000
	var best_item = null
	for key in elements.keys():
		if (best_dist > abs(elements[key] - value)):
			best_dist = abs(elements[key] - value)
			best_item = key

	return best_item
