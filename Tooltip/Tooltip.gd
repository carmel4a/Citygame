extends Control

onready var RTL = get_node("RTLabel")

func set_text(s):
	clear()
	RTL.set_size(Vector2(300,0))
	RTL.set_bbcode(s)
	update()

func clear():
	RTL.clear()
	update()


func _ready():
	update()

func update():
	yield(get_tree(), "idle_frame")
	RTL.set_size(Vector2(RTL.get_size().width, RTL.get_v_scroll().get_max()))
	set_size(RTL.get_size())