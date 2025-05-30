extends RayCast2D

var ignore_character: Node
var direction: Vector2
var time = 1.0
var sweep = 45.0
var tween

func _ready() -> void:
	global_rotation = direction.direction_to(Vector2(0, 0)).angle()
	tween = get_tree().create_tween()
	var local_sweep = global_rotation_degrees + sweep
	$Timer.start(time)
	tween.tween_property(self, "global_rotation_degrees", local_sweep, time)

func _physics_process(delta: float) -> void:
	self.global_position = ignore_character.global_position
	var collision_point = Vector2(400,100)#: Vector2
	force_raycast_update()
	
	if is_colliding():
		collision_point = to_local(get_collision_point())
	$Line2D.points[1] = collision_point
	$CPUParticles2D2.position = collision_point
	$CPUParticles2D2.rotation = collision_point.direction_to(Vector2(0, 0)).angle()
	$Beam_particles.position = collision_point * 0.5
	$Beam_particles.emission_rect_extents.x = collision_point.length() * 0.5


func _on_timer_timeout() -> void:
	self.queue_free()
