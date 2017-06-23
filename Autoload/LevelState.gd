extends Node

func _process(delta):
	
	_process_adding()

# array of [x,y,where,what]
func add_cell(c=[[]]):
	
	Global.Level._add(c)
# Shows helper of entitie (MUST be in tiileset) and start processing input
# in order to add that.

var klick = false
func _unhandled_input(event):
	
	if event.type==InputEvent.MOUSE_BUTTON:
		if event.is_pressed() == true and event.button_index==1:
			klick = "l"
			get_tree().set_input_as_handled()
		elif event.is_pressed() == true and event.button_index==2:
			klick = "r"
			get_tree().set_input_as_handled()
		else:
			klick = false
		