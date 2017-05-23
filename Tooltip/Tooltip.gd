extends Control

onready var RTL = get_node("RTLabel")

func set_text(s):
	clear()
	RTL.set_bbcode(s)
	update()

func clear():
	RTL.clear()
	update()

func _ready():
	RTL.set_size(Vector2(120,0))
	

func update():
	yield(get_tree(), "idle_frame")
	RTL.set_size(Vector2(120, RTL.get_v_scroll().get_max()))
	set_size(RTL.get_size())
