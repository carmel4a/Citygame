extends Node

func _ready():
	get_parent().set_perk(3)
	
	get_parent().set_perk(1)
	
func perk_1():
	
	for i in range(2):
		LevelState.adding_to_map("Roads",0,"Road")
		get_parent().wait_for("adding_to_map")
		yield()
	for i in range(2):
		LevelState.adding_to_map("Items",0,"House")
		get_parent().wait_for("adding_to_map")
		yield()
	get_parent().get_children()[0].set_disabled(true)

	
func perk_3():
	
	LevelState.adding_to_map("Items",0,"House")
	get_parent().wait_for("adding_to_map")
	yield()
	get_parent().get_children()[2].set_disabled(true)
