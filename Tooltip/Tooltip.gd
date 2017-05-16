extends Control

onready var RTL = get_node("RTLabel")

func set_text(s):
	get_node("RTLabel").set_bbcode(s)
	get_node("RTLabel").update()

func clear():
	get_node("RTLabel").clear()
	get_node("RTLabel").update()

func preupdate():
	get_node("RTLabel").set_size(Vector2(300,0))
#	get_node("RTLabel").set_size(Vector2(get_node("RTLabel").get_size().x,0))
	
func update():
	get_node("RTLabel")._first = false
#	set_size(Vector2(0,0))
	get_node("RTLabel").update()
	
