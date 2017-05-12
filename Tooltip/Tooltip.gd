extends Control

onready var RTL = get_node("RTLabel")

func set_text(s):
	get_node("RTLabel").set_bbcode(s)
	get_node("RTLabel")._first = false
	get_node("RTLabel")._ready()

func clear():
	get_node("RTLabel").clear()
	get_node("RTLabel")._first = false
	get_node("RTLabel")._ready()
