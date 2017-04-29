extends Control

var TurnAlert = preload("res://UI/TurnAlert/TurnAlert.tscn")
var Card = preload("res://Card/Card.tscn")

func _ready():

	get_node("Stats/Button").connect("button_down",get_node("../../"),"_next_turn")
	_update(["Stats/Label"])
	set_process_input(true)
	
func _update(what):
	
	for i in what:
		if i == "Stats/Label":
			get_node("Stats/Label").set_text("IP: " + str(GlobalMethods.get_IP()) + " (" + str(GlobalMethods.get_IP_diff()) + ")")

func add_card(what = null):
	
	var _c = Card.instance()
	_c._init(what)
	add_child(_c)
