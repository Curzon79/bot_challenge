extends Node2D

var current_room = 0

@export var rooms_selection = Globals.RoomType.MENU
var rooms = {}

func _ready() -> void:
	rooms = Globals.ROOMS[rooms_selection]
	load_room()


func load_room() -> void:
	#load room preview
	var room = rooms[current_room]
	$room_select/Room_name.text = room["name"]
	$room_select/Room_image.texture = load(room["preview"])
	
	# load bot selection
	for node in $bot_select.get_children():
		$bot_select.remove_child(node)
		node.queue_free() 
	
	for i in range(room["positions"]):
		$bot_select.add_child(create_bot_selector())

func create_bot_selector():
	var selector = OptionButton.new()
	for key in Globals.BOTS: 
		selector. add_item(key)
	return selector

func next_room():
	current_room = (current_room + 1) % len(rooms)
	load_room()

func last_room():
	current_room = (current_room - 1) % len(rooms)
	load_room()

func start_game():
	var room = rooms[current_room]
	
	#prepare battle: room + bots
	var scene = load(room["scene"]).instantiate()
	var bots = []
	for selector in $bot_select.get_children():
		bots.append(Globals.BOTS[selector.get_item_text(selector.get_selected_id())])
	scene.set_bots(bots)
	
	#replace scene
	get_tree().root.add_child(scene)
	get_node("/root/menu").queue_free()
	
