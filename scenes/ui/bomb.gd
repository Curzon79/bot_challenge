extends Node2D


var time = 1.0
var damage = 1.0
var ignore_character: Node

func _ready() -> void:
	$functional/Timer.wait_time = time
	


func explode():
	$visuals/explosion_particles.emitting = true
	$visuals/smoke.emitting = false
	$visuals/Polygon2D.visible = false
	
	$Explosion.play()
	$functional/Area2D/CollisionShape2D.set_deferred("disabled", false)




func _on_timer_timeout() -> void:
	explode()


func _on_explosion_particles_finished() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("receive_damage"):
		if body == ignore_character:
			return
		body.receive_damage(damage)
