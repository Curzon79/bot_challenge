extends Node2D

var ignore_character : Node2D
var duration: float
var size: float

func _ready() -> void:
	scale = Vector2(size, size)
	$visuals/CPUParticles2D.emitting = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if ("freeze_time" in body):
		if body == ignore_character:
			return
		body.freeze_time = duration


func _on_cpu_particles_2d_finished() -> void:
	queue_free()
