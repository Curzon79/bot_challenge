extends Area2D

class_name Projectile

var damage = 1.0


var direction : Vector2
var ignore_character: Node

var alive = true

const SPEED = 800

func set_size(size: float, damage: float):
	self.damage = damage
	self.scale = Vector2(size, size)

func _on_body_entered(body: Node2D) -> void:
	if ! alive:
		return
	if body == ignore_character:
		return
	if body.has_method("receive_damage"):
		if ! body.alive:
			return
		body.receive_damage(damage)
		self.visible = false
		$AudioStreamPlayer.play()
		alive = false
	else:
		self.queue_free()

func _process(delta: float) -> void:
	if (direction.length_squared() == 0):
		self.queue_free()
	global_position += direction * delta * SPEED
	


func _on_audio_stream_player_finished() -> void:
	self.queue_free()
