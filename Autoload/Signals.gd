extends Node

func _ready():
	add_user_signal("emited")
	add_user_signal("next_turn")
	add_user_signal("pre_next_turn")
	add_user_signal("Cancel")
	add_user_signal("adding_to_map")

func _emit_thread(n):
	
	emit_signal(n)
	emit_signal("emited",n)
	print("Signals emitted "+n)
	Global.Game.threads[1].wait_to_finish()
	return

func emit(n):
	
	if !Global.Game.threads[1].is_active():
		call_deferred("emit",n)
	else:
		Global.Game.threads[1].start(self,"_emit_thread",n)

var tooltip_ready = false
func connect_to_tooltip(obj,bbcode):
	if tooltip_ready:
		obj.connect("mouse_enter",Global.Popups.get_node("tooltip_auto"),"_on_hover",[obj,bbcode])
		obj.connect("mouse_exit",Global.Popups.get_node("tooltip_auto"),"_on_lost_focus")
	else:
		yield(get_tree(),"idle_frame")
		connect_to_tooltip(obj,bbcode)