extends RayCast2D

var ignore_character: Node
var direction: Vector2
var time = 1.0
var sweep = 45.0
var tween
var damage

func _ready() -> void:
	$CPUParticles2D2.color = modulate
	$CPUParticles2D.color = modulate
	$Beam_particles.color = modulate
	$Line2D2.default_color = modulate
	modulate = Color.WHITE
	
	var local_sweep = global_rotation_degrees + sweep
	
	global_rotation = direction.angle() - deg_to_rad(sweep * 0.5)
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "global_rotation_degrees", local_sweep, time)
	
	$Timer.start(time)

func _physics_process(delta: float) -> void:
	self.global_position = ignore_character.global_position
	var collision_point : Vector2
	
	force_raycast_update()
	if is_colliding():
		collision_point = to_local(get_collision_point())
		var collider = get_collider()
		if collider is Fighter and collider != ignore_character:
			collider.receive_damage(damage)
			
	$Line2D.points[1] = collision_point
	$Line2D2.points[1] = collision_point
	$CPUParticles2D2.position = collision_point
	$CPUParticles2D2.rotation = collision_point.direction_to(Vector2(0, 0)).angle()
	$Beam_particles.position = collision_point * 0.5
	$Beam_particles.emission_rect_extents.x = collision_point.length() * 0.5


func _on_timer_timeout() -> void:
	self.queue_free()
