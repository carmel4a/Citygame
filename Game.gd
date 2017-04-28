extends Node2D

var Turn = 0
var acc_IP = 10
var dif_IP = 0

func _enter_tree():
	
	randomize()
	
func _next_turn():

	Turn += 1
	acc_IP += dif_IP
	generate_allerts()
	
func generate_allerts():

	for i in range(randi()%2+1):
		var _b = get_node("CanvasLayer/UI").TurnAlert.instance()
		_b.show()
		_b.set_text("Turn: "+ str(Turn))
		get_node("CanvasLayer/UI/ScrollContainer/VButtonArray").add_child(_b)