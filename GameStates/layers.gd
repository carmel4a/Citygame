extends Node

var klick = GameState.klick

func layers():
	Global.Helpers.delete_light_helpers()
	var _il = Global.UI.get_node("right_panel/VBoxContainer/ItemList")
	_il.show()
	var _si = _il.get_selected_items()
	var _msx = Global.Level.map_size.x
	var _msy = Global.Level.map_size.y
	var _tex = preload("res://UI/map_icons/res.png")
	var _rec =Rect2(Vector2(0,0),Vector2(0,0))
	for x in range(_msx):
		for y in range(_msy):
			for j in Global.Level._content[x][y]:
				for i in _si:
					if j.keys()[0]==(_il.get_item_text(i)):
						Global.Helpers.light_static_helper(_tex,false,_rec,Vector2(2,2),Vector2(x*64,y*64))

func p_layers():
	klick = GameState.klick

func e_layers():
	print("exit layers")
	Global.Helpers.delete_light_helpers()
	Global.UI.get_node("right_panel/VBoxContainer/ItemList").hide()
