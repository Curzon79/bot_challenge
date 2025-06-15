extends Improvement

class_name Imp_Repair_Module

@export var repair_per_second = 1.0

func get_description() -> String:
	return "Passively repairs the bot.\n \n Repair: {repair} /s".format({"repair" : repair_per_second})


func call_post_process(bot: CustomBot, delta: float):
	bot.repair(repair_per_second * delta)
