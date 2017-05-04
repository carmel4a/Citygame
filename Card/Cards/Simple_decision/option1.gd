extends Node

func _ready():
	get_parent().set_perk(3)
	get_parent().get_children()[2].connect("pressed",self,"building")
	get_parent().set_perk(1)
	get_parent().get_children()[0].connect("pressed",self,"building1")
func building():
	for i in range(2):
		LevelState.adding_to_map("Roads",0,"Road")
		print("preyelded")
		yield(Global,"done")
		print("yelded")

func building1():
	for i in range(2):
		LevelState.adding_to_map("Items",0,"House")
		
