extends Button
var type
func _ready():
	if type == "Card":
		set_text("Card from Turn"+str(GlobalMethods.get_turn_no()))
	if type == "Init":
		set_text("Init")
	
func _on_Button_button_down():
	if type == "Card":
		get_node("../../../").add_card()
	queue_free()