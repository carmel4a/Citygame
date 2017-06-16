extends Control

var width = 120 setget set_width
var margin = 5
var _auto = false

onready var RTL = get_node("RTLabel")

func _ready():
	
	RTL.set_size(Vector2(width,0))
	clear()
	update()
	hide()
	if _auto:
		connect("mouse_enter",self,"_on_me",[true])
		connect("mouse_exit",self,"_on_me",[false])
		get_node("Timer").set_one_shot(true)
		get_node("Timer").set_wait_time(0.5)
		get_node("Timer").set_one_shot(true)
		get_node("mouse_exit").set_wait_time(0.2)

func set_text(s):
	
	clear()
	yield(get_tree(),"idle_frame")
	RTL.set_bbcode(s)
	update()
	show()

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

var _on_me = false
var howered = null
func _on_hover(obj,tooltip):
	
	if _auto:
		howered = [obj,tooltip]
		get_node("mouse_exit").stop()
		get_node("Timer").stop()
		get_node("Timer").start()

func _on_timeout():
	
	if _auto:
		set_text(howered[1])
		set_pos(Global.UI.get_local_mouse_pos()-Vector2(get_size().x-5,5))
		raise()

func _on_lost_focus():
	
	if !_on_me and _auto:
		get_node("mouse_exit").start()

func _on_me(tf):
	
	if _auto:
		_on_me=tf
		if _on_me:
			get_node("mouse_exit").stop()
		else:
			get_node("mouse_exit").start()

func _timeout():
	
	if _auto:
		get_node("Timer").stop()
		get_node("mouse_exit").stop()
		howered=null
		clear()
		hide()
