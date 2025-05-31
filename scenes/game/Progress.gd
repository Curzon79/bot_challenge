extends Node

const DEFAULT_ROOMS = [
	{
		"name": "Garden",
		"scene": "res://scenes/rooms/room_empty.tscn",
		"preview": "res://res/room1.png",
		"positions" : 2
	},
	{
		"name": "Garage",
		"scene": "res://scenes/rooms/room_empty.tscn",
		"preview": "res://res/room2.png",
		"positions" : 2
	},
	{
		"name": "Colliseum",
		"scene": "res://scenes/rooms/room_empty.tscn",
		"preview": "res://res/room3.png",
		"positions" : 2
	},
]

var rooms : Array = []
var player_character: BotDefinition
var player_inventory: Inventory

func _init():
	rooms = DEFAULT_ROOMS.duplicate()
	
	player_character = BotDefinition.new()
	player_character.hull = load("res://scenes/bots/parts/hull_t1_std.tres")
	player_character.weapons.append(load("res://scenes/bots/parts/weapon_t1_cannon.tres") )
	player_inventory = Inventory.new()

func get_next_room():
	return rooms.pop_front()
