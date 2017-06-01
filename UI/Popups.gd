extends Node

var Popups = {\
	"Init":preload("res://UI/Popups/Card/Card.tscn"),
	"NewTurn":preload("res://UI/Popups/Card/Card.tscn"),
	"Card":preload("res://UI/Popups/Card/Card.tscn"),
}

var AlertButton = preload("res://UI/AlertButton/AlertButton.tscn")
var tooltip = preload("res://Tooltip/Tooltip.tscn")

# should be in other place. it's game logic
func generate_turn_alerts():
	
	var _alert = generate_popup("NewTurn")
	generate_alert(_alert)
	for i in range(randi()%2+1): # 1-2 cards
		var _alert = generate_popup("Card","Simple_decision")
		generate_alert(_alert,["Card","Simple_decision"])
# Generate start turn popups AND in game popups 
# as result of action (e.g. oportunity of building 
# something, lack of resources).

func generate_alert(ref, args=null):
	
	var _b = AlertButton.instance()
	_b.init(ref, args)
	_b.show()
	Global.UI.get_node("Alerts/AlertsArray").add_child(_b)

func generate_popup(what,args = null):
	
	var _p = Popups[what].instance()
	_p.init(args)
	_p.set_name(what)
	_p.hide()
	add_child(_p,true)
	return(_p)

func create_tooltip(name, background = true):
	
	var _t = tooltip.instance()
	_t.set_name(name)
	add_child(_t)
