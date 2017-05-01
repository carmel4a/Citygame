extends Button
var type
var what
func _ready():
	
	if type == "Card":
		# some fcns to random choose a card
		var random_cardd = "Simple_decision"
		what = random_cardd
		set_text("Card from Turn"+str(GameState._Turn)+" | "+what)
	if type == "Init":
		set_text("Init")
	
func _on_Button_button_down():
	if type == "Card":
		get_node("../../../").add_card(what)
	queue_free()