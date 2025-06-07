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
	$functional/Area2D/CollisionShape2D.disabled = false

func _process(delta: float) -> void:
	var ovearlapping_bodies = $functional/Area2D.get_overlapping_bodies()
	if ovearlapping_bodies.size() >=1:
		if ovearlapping_bodies[0].has_method("recive_damage"):
			if ovearlapping_bodies[0] == ignore_character:
				return
			ovearlapping_bodies[0].recive_damage()


func _on_timer_timeout() -> void:
	explode()


func _on_explosion_particles_finished() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("recive_damage"):
		if body == ignore_character:
			return
			body.recive_damage()
