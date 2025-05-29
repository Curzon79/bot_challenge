extends "res://scenes/Controller.gd"

var last_command = Command.new(Command.IDLE, Vector2())
var duration = 0
var shoot_timeout = 0

var vision_enemies = {}
var vision_bullets = {}
var track_bullets = {}

var last_positions = []
var optimal_move_direction = Vector2()


const weight_random = 0.1
const weight_avoid_enemy = -0.1
const weight_explore = 0.2
const weight_avoid_walls = 0.4

const move_duration = 20

func get_color():
	return Color.PALE_VIOLET_RED
	
func getNextCommand(cast:Node, shape_cast: Node, delta:float) -> Command:
	shoot_timeout -= delta
	
	raycast_sweep(cast)
	
	#when possible shoot
	if shoot_timeout <= 0:
		var shoot_direction = get_direction_to_closest_enemy(cast.global_position)
		if (shoot_direction == Vector2()):
			shoot_direction = get_random_direction()
		shoot_timeout = 0.1
		return Command.new(Command.SHOOT, shoot_direction)
		
		
	#check for evasion
	var evasion_dir = check_for_evasion(shape_cast)
	if (evasion_dir):
		last_command = Command.new(Command.MOVE, evasion_dir)
		duration = move_duration
		return last_command

	#check for wall proximity
	if (optimal_move_direction != Vector2()):
		last_command.direction = last_command.direction * (1.0 - weight_avoid_walls) \
								+ optimal_move_direction * weight_avoid_walls

	if (duration > 0):
		duration -= 1
		return last_command
	
	var choice = randf()

	last_command = Command.new(Command.MOVE, 
	get_move_direction(cast.global_position))
	duration = move_duration
	
	return last_command

func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()

func get_move_direction(position) -> Vector2:
	#away from corners : optimal_move_direction
	#away from nearest enemy
	var away_from_enemy_direction = get_direction_to_closest_enemy(position) * -1
	
	var base_direction = Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
	
	var explore_direction = Vector2()
	var weight = 1.0
	for last_position in last_positions:
		explore_direction = explore_direction + (position - last_position) * weight
		weight *= 0.95
	
	return base_direction * weight_random \
			+ away_from_enemy_direction * weight_avoid_enemy \
			+ explore_direction * weight_explore

func get_direction_to_closest_enemy(position:Vector2) -> Vector2:
	var nearest = Vector2()
	var min_dist = 100000.0
	for enemy in vision_enemies:
		var dist = position.distance_squared_to(vision_enemies[enemy])
		if (dist < min_dist):
			min_dist = dist
			nearest = vision_enemies[enemy]

	if (nearest == Vector2()):
		return Vector2()
	
	return position.direction_to(nearest)

#function to weigh the distances for optimal direction to stay away from walls
func move_dir_weight_function(value: float) -> float:
	return min(value - 50, 0)
	

func raycast_sweep(cast:Node):
	optimal_move_direction = Vector2() 
	vision_enemies.clear()
	vision_bullets.clear()
	
	for angle in range(0, 360, 10):
		cast.target_position = Vector2(1000, 0).rotated(deg_to_rad(angle))
		cast.force_raycast_update()		
		var collider = cast.get_collider()
		if (collider is Fighter):
			vision_enemies[collider] = collider.global_position
		
		if (collider is Projectile):
			vision_bullets[collider] = collider.global_position
		
		var dist = (cast.get_collision_point() - cast.global_position).length()
		optimal_move_direction += move_dir_weight_function(dist) * Vector2(1, 0).rotated(deg_to_rad(angle))
		
	optimal_move_direction = optimal_move_direction.normalized()

func check_for_evasion(shape_cast):
	for bullet in vision_bullets:
		add_entry(track_bullets, bullet)
		var direction = check_path(shape_cast, bullet)
		
		if (direction):
			return direction.rotated(deg_to_rad(90))
		
	return null

func check_path(shape_cast, bullet):
	#var path = track_bullets[bullet]
	#extrapolate direction - or use from object
	#var direction = Vector2()
	#for step in path:
	#	direction += step
	#direction = direction.normalized()
	var direction = bullet.direction
	shape_cast.target_position = direction * -400
	shape_cast.force_shapecast_update()
	for i in shape_cast.get_collision_count():
		if (shape_cast.get_collider(i) == bullet):
			return direction
		
	return null

func add_entry(dict:Dictionary, node):
	if (! dict.has(node)):
		dict[node] = []
		
	dict[node].append( node.global_position )
