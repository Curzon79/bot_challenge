extends Improvement

class_name Imp_Ram_Module

@export var ram_damage = 1.0
@export var cooldown = 1.0

func call_post_process(bot: CustomBot, delta: float):
	var controller = bot.controller
	var runtime_data = {}
	if (controller.runtime_data.has("Ram")):
		runtime_data = controller.runtime_data["Ram"]
	var collider_keys = runtime_data.keys()
	
	for i in bot.get_slide_collision_count():
		var collision = bot.get_slide_collision(i)
		var collider = collision.get_collider()
		
		if (collider.has_method("receive_damage")):
			if (runtime_data.has (collider) and runtime_data[collider] > 0):
				runtime_data[collider] -= delta
				collider_keys.erase(collider)
				continue
			runtime_data[collider] = cooldown
			collider.receive_damage(ram_damage)

	#cleanup all data that we don't collide with
	for key in collider_keys:
		runtime_data.erase(key)

	controller.runtime_data["Ram"] = runtime_data
