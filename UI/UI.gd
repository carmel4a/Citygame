extends Control

var TurnAlert = preload("res://UI/TurnAlert/TurnAlert.tscn")
var Card = preload("res://Card/Card.tscn")

func _ready():

	get_node("Stats/NextTurn").connect("button_down",get_node("../../"),"_next_turn")
	_update(["Stats/Label"])

func _update(what=null):
	if what == null:
		get_node("Stats/IP").set_text("IP: " + str(GameState.Auth[0]) + " (" + str(GameState.Auth[1]) + ")")
		get_node("Stats/Pop").set_text("Popultaion: " + str(GameState.pop[0]) + "/" + str(GameState.pop[1]) + " (" + str(GameState.pop[2]) + ")")
	else:
		if what == "Stats/IP":
			get_node("Stats/Pop").set_text("IP: " + str(GameState._Auth) + " (" + str(GameState._d_Auth) + ")")
		if what == "Stats/Pop":
			get_node("Stats/IP").set_text("Popultaion: " + str(GameState.pop[0]) + "/" + str(GameState.pop[1]) + " (" + str(GameState.pop[2]) + ")")

func add_card(what = null):
	
	var _c = Card.instance()
	_c._init(what)
	get_node("Cards").add_child(_c)
