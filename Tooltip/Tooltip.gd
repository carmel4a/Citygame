extends Control

var width = 120 setget set_width
var margin = 5

onready var RTL = get_node("RTLabel")

func _ready():
	
	RTL.set_size(Vector2(width,0))
	clear()
	update()

func set_text(s):
	
	clear()
	yield(get_tree(),"idle_frame")
	RTL.set_bbcode(s)
	update()

func clear():
	
	RTL.clear()
	update()


func update():
	
	yield(get_tree(), "idle_frame")
	RTL.set_size(Vector2(width, RTL.get_v_scroll().get_max()))
	set_size(RTL.get_size()+Vector2(margin*2,margin*2))
	RTL.set_anchor_and_margin(0,0,margin)
	RTL.set_anchor_and_margin(1,0,margin)
	RTL.set_anchor_and_margin(2,1,margin)
	RTL.set_anchor_and_margin(3,1,margin)
func set_width(w):
	
	width = w
	update()
