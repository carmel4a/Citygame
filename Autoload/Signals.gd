extends Node

func _ready():
	add_user_signal("emited")
	add_user_signal("next_turn")
	add_user_signal("pre_next_turn")
	add_user_signal("Cancel")
	add_user_signal("adding_to_map")

func emit(n):
	emit_signal(n)
	emit_signal("emited",n)
	print("Signals emitted "+n)

var tooltip_ready = false
func connect_to_tooltip(obj,bbcode):
	if tooltip_ready:
		obj.connect("mouse_enter",Global.Popups.get_node("tooltip_auto"),"_on_hover",[obj,bbcode])
		obj.connect("mouse_exit",Global.Popups.get_node("tooltip_auto"),"_on_lost_focus")
	else:
		yield(get_tree(),"idle_frame")
		connect_to_tooltip(obj,bbcode)