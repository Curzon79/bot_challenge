extends Object

class_name Command

enum {IDLE, MOVE, SHOOT, 
	SHOOT_W1, SHOOT_W2, SHOOT_W3	#special shoot commands fro custom bot
	}

var type = IDLE
var direction = Vector2()

func _init(_type, direction:Vector2) -> void:	
	self.type = _type
	self.direction = direction.normalized()
	
	if (direction == Vector2() and type != IDLE):
		self.type = IDLE
