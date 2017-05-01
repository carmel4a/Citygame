extends Node

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
	Global.UI.get_node("ScrollContainer/VButtonArray").add_child(_b)
