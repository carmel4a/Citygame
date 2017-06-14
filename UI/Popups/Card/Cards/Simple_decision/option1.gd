extends Node

func _ready():
	
	get_parent().set_perk(3)
	get_parent().set_perk(1)

func perk_1():
	
	for i in range(2):
		get_parent().wait_for("adding_to_map")
		LevelState.adding_to_map("Roads",0,"Road")
		yield()
	for i in range(2):
		get_parent().wait_for("adding_to_map")
		LevelState.adding_to_map("Items",0,"House")
		yield()
	print("after perk's work")
	get_parent().call_deferred("end_perk",1)

func perk_3():
	
	get_parent().wait_for("adding_to_map")
	LevelState.adding_to_map("Items",0,"House")
	yield()
	get_parent().call_deferred("end_perk",3)
