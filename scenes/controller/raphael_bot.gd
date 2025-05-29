extends "res://scenes/Controller.gd"

var duration = 0
var last_command = Command.new(Command.IDLE, Vector2())
var shoot_timeout = 0
var enemy_position : Vector2

var knows_enemy = false

var time : float

var vision_enemies = []
var vision_bullets = []

const search_space = 1000

enum State {DEFEND, SEARCH, ATTACK}

func get_color():
	return Color.DARK_GREEN

func getNextCommand(cast:Node, _shapecast:Node, delta:float) -> Command:
	time += delta
	var input = get_next_move(cast)
	match input:
		State.DEFEND:
			return  defend(cast, delta)
		State.SEARCH:
			return  search(cast, delta)
		State.ATTACK:
			return attack(cast,delta)
	return  Command.new(Command.IDLE, Vector2())

func get_direction(cast) -> Vector2:
	if knows_enemy:
		return cast.global_position.direction_to(enemy_position).rotated(deg_to_rad(sin(time * 10) * 50))
	else:
		return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()

func search(cast,delta):
	shoot_timeout -= delta
	
	if shoot_timeout <= 0:
		shoot_timeout = 0.10
		return Command.new(Command.SHOOT, 
					get_direction(cast))
		
	if (duration > 0):
		duration -= 1
		return last_command
	
	var choice = randf()

	last_command = Command.new(Command.MOVE, 
	get_direction(cast))
	duration = 20
	
	return last_command

func defend(cast, delta):
	shoot_timeout -= delta
	if shoot_timeout <= 0:
		shoot_timeout = 0.10
		return Command.new(Command.SHOOT, 
			cast.global_position.direction_to(enemy_position))
	return Command.new(Command.MOVE, 
			Vector2(1,1))

func attack(cast, delta):
	shoot_timeout -= delta
	if shoot_timeout <= 0:
		shoot_timeout = 0.10
		return Command.new(Command.SHOOT, 
			cast.global_position.direction_to(enemy_position).rotated(deg_to_rad(sin(time * 10) * 2)))
	return Command.new(Command.MOVE, 
		cast.global_position.direction_to(enemy_position))

func get_next_move(cast):
	var curr_state = State.SEARCH
	raycast_sweep(cast)
	if vision_enemies.size() > 0:
		knows_enemy = true
		var collider = vision_enemies[0]
		var nearest_distance = (collider.global_position - cast.global_position).length()
		for enemy in vision_enemies:
			if (enemy.global_position - cast.global_position).length() <= nearest_distance:
				nearest_distance = (enemy.global_position - cast.global_position).length()
				collider = enemy
		if collider is Fighter:
			enemy_position = collider.global_position 
			cast.target_position = enemy_position - cast.global_position
			curr_state = State.ATTACK
		else: curr_state = State.SEARCH
	return curr_state


func raycast_sweep(cast:Node):
	vision_enemies = []
	vision_bullets = []
	
	for angle in range(0, 360, 10):
		cast.target_position = Vector2(1000, 0).rotated(deg_to_rad(angle))
		cast.force_raycast_update()		
		var collider = cast.get_collider()
		if (collider is Fighter):
			vision_enemies.append(collider)
		
		if (collider is Projectile):
			vision_bullets.append(collider)
