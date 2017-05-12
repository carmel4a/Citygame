extends Node

var tooltip = preload("res://Tooltip/Tooltip.tscn")

func generate_turn_alerts():
	
	generate_alert("Init")
	for i in range(randi()%2+1): # 1-2 cards
		generate_alert("Card")

# Generate start turn popups AND in game popups 
# as result of action (e.g. oportunity of building 
# something, lack of resources).

# Only type of alert is too few information... (no data)
func generate_alert(ty):
	
	var _b = Global.UI.TurnAlert.instance()
	_b.type = ty
	_b.show()
	Global.UI.get_node("Alerts/AlertsArray").add_child(_b)

func tooltip(name):
	
	var _t = tooltip.instance()
	_t.set_name(name)
	Global.HUD.add_child(_t)
