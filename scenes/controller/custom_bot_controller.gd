extends "res://scenes/Controller.gd"
class_name BotController

var bot_definition:BotDefinition

var last_command = Command.new(Command.IDLE, Vector2())
var duration = 0

const SHOOT_CMDS = [Command.SHOOT_W1, Command.SHOOT_W2, Command.SHOOT_W3]

const BASE_VISION = 100.0

#sweep variables
var vision_enemies = {}
var vision_bullets = {}
var vision_all = {}

#custom data for slot items
var runtime_data = {}

func get_color():
	return Color.GREEN_YELLOW

func set_bot(bot_definition):
	self.bot_definition = bot_definition
	bot_definition.update()

func getNextCommand(cast:Node, shape_cast: Node, delta:float) -> Command:
	var command = getNextCommand_internal(cast, shape_cast, delta)

	#do post processing
	bot_definition.call_post_process(cast.get_parent(), delta)
	
	return command
	
func getNextCommand_internal(cast:Node, shape_cast: Node, delta:float) -> Command:
	var bot = cast.get_parent()
	
	raycast_sweep(cast)
	
	#check if any shoot is possible
	var command = check_weapon_availability(bot)
	if (command != null):
		return command
	
	#call Move Prio Hook
	command = bot_definition.call_move_prio(bot)
	if (command != null):
		last_command = command
		duration = 5
		return command
	
	#check if a command is still active
	if (duration > 0):
		duration -= 1
		return last_command
	
	#call Move Hook
	var current_direction = last_command.direction
	command = bot_definition.call_move(bot, current_direction)
	if (command != null):
		last_command = command
		return command
		
	#fallback: random move
	last_command = Command.new(Command.MOVE, (current_direction + get_random_direction() * 0.2).normalized())
	return last_command


func raycast_sweep(cast:Node):
	vision_enemies.clear()
	vision_bullets.clear()
	vision_all.clear()
	
	var vision_range = bot_definition.get_modifier(cast.get_parent(), BotDefinition.Hook.MOD_VISION, BASE_VISION)
	if cast.get_parent().has_node("Radar"):
		cast.get_parent().radar.scale = Vector2(vision_range, vision_range) / 500
	for angle in range(0, 360, 6):
		cast.target_position = Vector2(vision_range, 0).rotated(deg_to_rad(angle))
		cast.force_raycast_update()		
		var collider = cast.get_collider()
		if (collider is Fighter):
			vision_enemies[collider] = collider.global_position
		elif (collider is Projectile):
			vision_bullets[collider] = collider.global_position
		elif (collider != null):
			if (!vision_all.has(collider)):
				vision_all[collider] = []
			vision_all[collider].append(cast.get_collision_point())
			
	
func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()


func check_weapon_availability(bot):
	for i in range(len(bot_definition.weapons)):
		if (bot.weapon_cooldowns[i].time_left <= 0):
			return Command.new(SHOOT_CMDS[i], get_aim_direction(bot, vision_enemies.keys()))
		
	return null

func get_aim_direction(bot, targets):
	return bot_definition.call_aim(bot, targets).get_aim_direction()
