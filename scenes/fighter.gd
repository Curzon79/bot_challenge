extends CharacterBody2D

class_name Fighter

var rng = RandomNumberGenerator.new()

#definitions
const bullet = preload("res://scenes/projectile.tscn")

@export var allowed_commands = [Command.IDLE, Command.MOVE, Command.SHOOT, 
								Command.SHOOT_W1, Command.SHOOT_W2, Command.SHOOT_W3]
@export var controller_script:Script
var controller


#bot stats
@export var shoot_cooldown = 0.2
@export var speed = 400
@export var max_health = 3

#bot state
@export var health = 3
var alive = true
signal died

#current command
var command:Command = Command.new(Command.IDLE, Vector2())

func _ready() -> void:
	$cooldown.wait_time = shoot_cooldown
	controller = controller_script.new()

func set_controller(script: Script):
	controller_script = script
	controller = controller_script.new()

func _process(delta: float) -> void:
	if ! alive:
		return
	command = controller.getNextCommand($RayCast2D, $ShapeCast2D, delta)
	#execute current command (if allowed)
	if (!command.type in allowed_commands):
		return
	match command.type:
		Command.IDLE:
			pass
		Command.MOVE:
			velocity = command.direction * speed
			move_and_slide()
		Command.SHOOT:
			if $cooldown.get_time_left() > 0:
				return
			$cooldown.start()
			var pitch = rng.randf_range(1.00, 1.7)
			$AudioStreamPlayer.pitch_scale = pitch
			$AudioStreamPlayer.play()
			var new_bullet = bullet.instantiate()
			new_bullet.direction = command.direction
			new_bullet.ignore_character = self
			new_bullet.global_position = global_position
			new_bullet.get_node("CollisionShape2D/Light").modulate = modulate
			get_parent().add_child(new_bullet)

func set_color():
	if (controller.has_method("get_color")):
		modulate = controller.get_color()

func receive_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	if ! alive:
		return
		
	alive = false
	emit_signal("died")
	
	set_deferred("$CollisionShape2D.disabled", true)
	$AudioStreamPlayer2.play()
	$death_particles.emitting = true
	$Bot.visible = false
	$Light.visible = false
	$CPUParticles2D.visible = false


func _on_death_particles_finished() -> void:
	self.queue_free()
