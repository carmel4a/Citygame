extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var TurnAlert = preload("res://UI/TurnAlert/TurnAlert.tscn")

func _ready():
	get_node("Stats/Button").connect("button_down",get_node("../../"),"_next_turn")
	_update(["Stats/Label"])
	set_process_input(true)
func _update(what):
	for i in what:
		if i == "Stats/Label":
			get_node("Stats/Label").set_text("IP: " + str(GlobalMethods.get_IP()) + " (" + str(GlobalMethods.get_IP_diff()) + ")")