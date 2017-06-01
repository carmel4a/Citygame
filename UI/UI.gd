extends Control

func _ready():
	
	get_node("Stats/NextTurn").connect("pressed",get_node("../../"),"next_turn")
	update()

func update(what="all"):
	var _all = false
	if what == "all":
		_all = true
	if what == "Stats/IP" or _all:
		get_node("Stats/Pop").set_text("IP: " + str(GameState.Auth[0]) + " (" + str(GameState.Auth[1]) + ")")
	if what == "Stats/Pop" or _all:
		get_node("Stats/IP").set_text("Popultaion: " + str(GameState.pop[0]) + "/" + str(GameState.pop[1]) + " (" + str(GameState.pop[2]) + ")")
