extends Button

var type
var arg

func init(vtype, varg):
	type = vtype
	if varg != null:
		arg = varg
	else:
		arg = ["null"]

func _ready():
#	
	if arg[0] == "Card":
		var card
		if arg[1] == "def":
			# some fcns to random choose a card
			card = "Simple_decision"
			arg[1] = card
		else:
			card = arg[1]
		set_text("Card from Turn"+str(GameState._Turn)+" | "+arg[1])
	if arg[0] == "Init":
		set_text("Init")
	if arg[0] == "null":
		set_text("Error type of alert!")

	Global.UI.get_node("Alerts").set_stop_mouse(true)

func _on_pressed():
	
	type.show()
#	hide()
	queue_free()
	if Global.UI.get_node("Alerts/AlertsArray").get_child_count()==0:
		Global.UI.get_node("Alerts").set_stop_mouse(false)
