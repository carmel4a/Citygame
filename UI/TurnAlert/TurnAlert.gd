extends Button

func _on_Button_button_down():
	var _c = get_node("../../../card").duplicate()
	_c.show()
	get_node("../../../").add_child(_c)
	queue_free()
