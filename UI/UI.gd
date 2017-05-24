extends Control

var TurnAlert = preload("res://UI/TurnAlert/TurnAlert.tscn")
var Card = preload("res://Card/Card.tscn")

func _ready():

	get_node("Stats/NextTurn").connect("button_down",get_node("../../"),"_next_turn")
	_update(["Stats/Label"])

func _update(what):
	
	for i in what:
		if i == "Stats/Label":
			get_node("Stats/Label").set_text("IP: " + str(GameState._Auth) + " (" + str(GameState._d_Auth) + ")")

func add_card(what = null):
	
	var _c = Card.instance()
	_c._init(what)
	get_node("Cards").add_child(_c)
