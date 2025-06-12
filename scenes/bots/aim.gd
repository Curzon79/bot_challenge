extends Object

class_name Aim

enum SpreadType {RANDOM, SWEEP}

var direction = Vector2()
var accurracy: float = 1.0
var spread_type: SpreadType = SpreadType.RANDOM

func _init(direction: Vector2, accurracy: float, spread_type = SpreadType.RANDOM) -> void:
	self.direction = direction
	self.accurracy = min(accurracy, 1.0)
	self.spread_type = spread_type

func merge(other: Aim):
	self.spread_type = max( self.spread_type, other.spread_type)
	self.direction = self.direction if self.direction != Vector2() else other.direction
	self.accurracy = min(self.accurracy, other.accurracy)
	return self

func get_aim_direction() -> Vector2:
	if (direction == Vector2()): 
		return get_random_direction()

	var offset = 0
	match spread_type:
		SpreadType.RANDOM:
			offset = PI * 2 * (0.5 - randf()) * (max(1.0 - accurracy, 0.0))
		SpreadType.SWEEP:
			var offset_factor = sin(Time.get_ticks_msec() / 500.0)
			offset = offset_factor * PI * (max(1.0 - accurracy, 0.0))
	
	return direction.rotated(offset)

func get_random_direction() -> Vector2:
	return Vector2(randf() * 2.0 - 1, randf() * 2.0 - 1).normalized()
