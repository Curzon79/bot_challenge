extends Node

const PROGRESSION_FACTOR = 1.15
const BOSS_THRESHOLD = 220
const ELITE_1_RANK = 5
const ELITE_2_RANK = 7

const CHALLENGE_ROOMS = [
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
const ELITE_ROOM = {
		"name": "Challenge 1",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_1.tscn",
		"preview": "res://res/room1.png",
		"positions" : 1,
		"selection" : "elite"
	}

const BOSS_ROOM = {
		"name": "Boss",
		"scene": "res://scenes/rooms/challenge_rooms/boss_room_1.tscn",
		"preview": "res://res/room1.png",
		"positions" : 1,
		"selection": "boss"
	}	

const ENEMIES = {
	AMOEBA: 15,
	SNAIL_I: 40,
	SNAIL_II: 70,
	SNAIL_III: 100,
	FLY_I: 30,
	FLY_II: 40,
	FLY_III: 50,
	BEE_I: 70,
	BEE_II: 120,
	BEE_III: 160,
	WASP_I: 60,
	WASP_II: 90,
	WASP_III: 120,
	BAT_I: 100,
	BAT_II: 120,
	BAT_III: 180,
}

const ELITES = {
	HAWK_I: 160,
	HAWK_II: 190,
	HAWK_III: 220,
}

const BOSSES = [
	BOSS_1
]

const AMOEBA = "res://scenes/bots/enemies/Amoeba I.tres"
const BAT_I = "res://scenes/bots/enemies/Bat I.tres"
const BAT_II = "res://scenes/bots/enemies/Bat II.tres"
const BAT_III = "res://scenes/bots/enemies/Bat III.tres"
const BEE_I = "res://scenes/bots/enemies/Bee I.tres"
const BEE_II = "res://scenes/bots/enemies/Bee II.tres"
const BEE_III = "res://scenes/bots/enemies/Bee III.tres"
const FLY_I = "res://scenes/bots/enemies/Fly I.tres"
const FLY_II = "res://scenes/bots/enemies/Fly II.tres"
const FLY_III = "res://scenes/bots/enemies/Fly III.tres"
const SNAIL_I = "res://scenes/bots/enemies/Snail I.tres"
const SNAIL_II = "res://scenes/bots/enemies/Snail II.tres"
const SNAIL_III = "res://scenes/bots/enemies/Snail III.tres"
const WASP_I = "res://scenes/bots/enemies/Wasp I.tres"
const WASP_II = "res://scenes/bots/enemies/Wasp II.tres"
const WASP_III = "res://scenes/bots/enemies/Wasp III.tres"

#Elites
const HAWK_I = "res://scenes/bots/enemies/Hawk I.tres"
const HAWK_II = "res://scenes/bots/enemies/Hawk II.tres"
const HAWK_III = "res://scenes/bots/enemies/Hawk III.tres"

#Bosses
const BOSS_1 = "res://scenes/bots/enemies/boss_1.tres"

#var rooms : Array = []
var player_character: BotDefinition
var player_health: float
var player_inventory: Inventory

var player_progression =  100
var player_progression_rank = 0

func _init():
	#rooms = CHALLENGE_ROOMS.duplicate()
	
	reset()

func reset():
	player_progression =  100
	player_progression_rank = 0

	player_character = load("res://scenes/bots/bot_definitions/player_start.tres").duplicate()
	player_character.color = Color.CORAL
	player_health = player_character.hull.health
	player_inventory = Inventory.new()
	
	
func progress_difficulty():
	player_progression *= PROGRESSION_FACTOR
	player_progression_rank += 1

func get_next_room():
	if (player_progression > BOSS_THRESHOLD):
		return BOSS_ROOM
	if (player_progression_rank == ELITE_1_RANK or 
		player_progression_rank == ELITE_2_RANK):
		return ELITE_ROOM
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
