extends "res://scenes/fighter.gd"

class_name CustomBot

@export var bot_definition: BotDefinition 

const custom_controller_script = preload("res://scenes/controller/custom_bot_controller.gd")

var weapon_cooldowns = []

func _ready() -> void:
	#initialize bot
	weapon_cooldowns = [$cooldown, $cooldown2, $cooldown3]
	#set_bot_definition(bot_definition)
	update_health_indication()
	
	#$cooldown.wait_time = shoot_cooldown
	#controller = custom_controller_script.new()
	#controller.set_bot(bot_definition)


func set_bot_definition(bot_definition:BotDefinition):
	self.bot_definition = bot_definition
	controller = custom_controller_script.new()
	controller.set_bot(bot_definition)
	
	max_health = bot_definition.hull.health
	health = max_health
	speed = bot_definition.hull.speed
	self.modulate = bot_definition.color
	
	if (bot_definition.hull.sprite != null):
		$Bot.texture = bot_definition.hull.sprite

func set_controller(script: Script):
	controller_script = script
	controller = controller_script.new()
	controller.set_bot(bot_definition)

func _process(delta: float) -> void:
	if ! alive:
		return
	
	if check_freese(delta):
		return
	
	while (true): 
		#we allow multiple shoot command and a single move command
		command = controller.getNextCommand($RayCast2D, $ShapeCast2D, delta)
		#execute current command (if allowed)
		if (!command.type in allowed_commands):
			return
		match command.type:
			Command.IDLE:
				pass
				return
			Command.MOVE:
				velocity = command.direction * bot_definition.get_speed(self)
				var collided = move_and_slide()
				if (collided && controller.has_method("update_last_direction")):
					controller.update_last_direction(velocity.normalized())
				return
			Command.SHOOT_W1:
				shoot_weapon(command, 0)
			Command.SHOOT_W2:
				shoot_weapon(command, 1)
			Command.SHOOT_W3:
				shoot_weapon(command, 2)
			
	

func receive_damage(damage: float):
	health -= bot_definition.get_modifier(self, BotDefinition.Hook.MOD_RECEIVE_DAMAGE, damage)
	update_health_indication()
	if health <= 0:
		die()


func shoot_weapon(command, weapon_slot: int):
	if weapon_cooldowns[weapon_slot].get_time_left() > 0:
		return
	
	weapon_cooldowns[weapon_slot].wait_time = weapon_cooldowns[weapon_slot].get_time_left() + bot_definition.get_shoot_frequency(self, weapon_slot)
	weapon_cooldowns[weapon_slot].start()
	
	var pitch = rng.randf_range(1.00, 1.7)
	$AudioStreamPlayer.pitch_scale = pitch
	$AudioStreamPlayer.play()
	
	bot_definition.shoot_weapon(command, self, weapon_slot)
	
