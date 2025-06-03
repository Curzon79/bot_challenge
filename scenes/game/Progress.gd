extends Node

const CHALLENGE_ROOMS = [
	{
		"name": "Challenge 1",
		"scene": "res://scenes/rooms/challenge_rooms/room_empty_1.tscn",
		"preview": "res://res/room1.png",
		"positions" : 1
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
]

const ENEMIES = {
	PAWN : 10,
	FIGHTER_PEA: 50,
	FIGHTER_LIGHT: 50,
	FIGHTER_STD : 70,
	FIGHTER_HEAVY: 80,
	FIGHTER_VERY_HEAVY: 140,
}

const PAWN = "res://scenes/bots/enemies/pawn.tres"
const FIGHTER_HEAVY = "res://scenes/bots/enemies/fighter_heavy.tres"
const FIGHTER_LIGHT = "res://scenes/bots/enemies/fighter_light.tres"
const FIGHTER_PEA = "res://scenes/bots/enemies/fighter_pea.tres"
const FIGHTER_STD = "res://scenes/bots/enemies/fighter_std.tres"
const FIGHTER_VERY_HEAVY = "res://scenes/bots/enemies/fighter_very_heavy.tres"

#var rooms : Array = []
var player_character: BotDefinition
var player_inventory: Inventory

var player_progression = 100

func _init():
	#rooms = CHALLENGE_ROOMS.duplicate()
	
	player_character = BotDefinition.new()
	player_character.color = Color.CORAL
	player_character.hull = load("res://scenes/bots/parts/hull_t1_std.tres")
	player_character.weapons.append(load("res://scenes/bots/parts/weapon_t1_cannon.tres") )
	player_inventory = Inventory.new()

func progress_difficulty():
	player_progression += 10

func get_next_room():
	return CHALLENGE_ROOMS.pick_random()

func get_enemy_set(room:Dictionary):
	var enemy_set = []
	var enemy_set_value = 0
	var enemies = ENEMIES.keys()
	for i in range (room["positions"]):
		var enemy = enemies.pick_random()
		enemy_set.append(enemy)
		enemy_set_value += ENEMIES[enemy]
	
	#try to fix progression
	while (enemy_set_value > player_progression * 1.2 or 
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
