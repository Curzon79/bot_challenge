
class_name Globals



const BOTS = {
	"Simple" : "res://scenes/controller/default_bot.gd",
	"Alex Bot" : "res://scenes/controller/alex_bot.gd",
	"Raphael Bot" : "res://scenes/controller/raphael_bot.gd",
	"Raphael Cheater Bot" : "res://scenes/controller/raphael_cheater_bot.gd",
	"Hunter" : "res://scenes/controller/hunter_bot.gd",
	"Player (Keyboard)" : "res://scenes/controller/PlayerController.gd",
	"Player (Controller)" : "res://scenes/controller/controler_controler.gd",
	"Player Cheater (Controller)" : "res://scenes/controller/op_controler_player.gd",
	"Custom: default" : "res://scenes/bots/bot_definitions/default.tres"
}

enum RoomType {MENU, TEST}

const ROOMS = {
	RoomType.MENU: [
		{
			"name": "Garden",
			"scene": "res://scenes/rooms/room_1.tscn",
			"preview": "res://res/room1.png",
			"positions" : 2
		},
		{
			"name": "Garage",
			"scene": "res://scenes/rooms/room_2.tscn",
			"preview": "res://res/room2.png",
			"positions" : 4
		},
		{
			"name": "Colliseum",
			"scene": "res://scenes/rooms/room_3.tscn",
			"preview": "res://res/room3.png",
			"positions" : 5
		},
		{
			"name": "Labyrinth",
			"scene": "res://scenes/rooms/room_4.tscn",
			"preview": "res://res/room4.png",
			"positions" : 3
		},
		{
			"name": "Loft",
			"scene": "res://scenes/rooms/room_empty.tscn",
			"preview": "res://res/room_empty.png",
			"positions" : 2
		}
	], 
	RoomType.TEST: [
		{
		"name": "Evade Simple Test",
		"scene": "res://scenes/rooms/test_room_evade.tscn",
		"preview": "res://res/room_evade.png",
		"positions" : 1
		},
		{
		"name": "Evade Hard Test",
		"scene": "res://scenes/rooms/test_room_evade_2.tscn",
		"preview": "res://res/room_evade.png",
		"positions" : 1
		},
		{
		"name": "Evade Insane Test",
		"scene": "res://scenes/rooms/test_room_evade_3.tscn",
		"preview": "res://res/room_evade.png",
		"positions" : 1
		},
		{
		"name": "Hunt Single Test",
		"scene": "res://scenes/rooms/test_room_hunt2.tscn",
		"preview": "res://res/room_hunt.png",
		"positions" : 1
		},
		{
		"name": "Hunt Test",
		"scene": "res://scenes/rooms/test_room_hunt.tscn",
		"preview": "res://res/room_hunt.png",
		"positions" : 1
		},
		{
		"name": "Explore Test",
		"scene": "res://scenes/rooms/test_room_explore.tscn",
		"preview": "res://res/room_explore.png",
		"positions" : 1
		}
	]
}


const UPGRADES = {
	"t1": [
		"res://scenes/bots/parts/cpu_t1_aim_med.tres", 
		"res://scenes/bots/parts/cpu_t1_aim_weak.tres", 
		"res://scenes/bots/parts/imp_t1_engine.tres", 
		"res://scenes/bots/parts/weapon_t1_cannon.tres", 
		"res://scenes/bots/parts/weapon_t1_laser.tres",
		"res://scenes/bots/parts/slot_t1_cpu.tres", 
		"res://scenes/bots/parts/slot_t1_improvement.tres", 
	],
	"t2": [
		"res://scenes/bots/parts/cpu_t2_aim_perfect.tres",
		"res://scenes/bots/parts/weapon_t2_cannon_fast.tres",
		"res://scenes/bots/parts/slot_t2_weapon.tres"
	],
}
