extends Node

func _ready():
	
	get_parent().set_perk(3,"i am better. choose me!")
	get_parent().set_perk(1,"awsome perk")

func perk_1():
	
	for i in range(2):
		get_parent().wait_for("adding_to_map")
		LevelState.adding_to_map(Global.Level.tilemaps.get_node("Roads"),0,"Road")
		yield()
	for i in range(2):
		get_parent().wait_for("adding_to_map")
		LevelState.adding_to_map(Global.Level.tilemaps.get_node("Items"),0,"House")
		yield()
	print("after perk's work")
	get_parent().call_deferred("end_perk",1)

func perk_3():
	
	get_parent().wait_for("adding_to_map")
	LevelState.adding_to_map(Global.Level.get_node("Items"),0,"House")
	yield()
	get_parent().call_deferred("end_perk",3)
