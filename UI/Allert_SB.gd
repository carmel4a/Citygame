extends VScrollBar

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	
	set_process(true)
	
func _process(delta):
	
	if get_node("../").get_rect().end.y > get_viewport().get_rect().end.y:
		show()
	get_node("../").set_margin(3,10)