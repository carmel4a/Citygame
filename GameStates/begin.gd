extends Node

var _mp = GameState._mp
var klick = GameState.klick

func begin():
	
	Global.Popups.generate_popup("Init")
	Global.Popups.get_node("Init").show()
	Global.Popups.get_node("Init").set_pos(Global.Game.get_viewport_rect().size/2)
	Global.Popups.get_node("Init").connect("exit_tree",self,"_on_Init_close",[],4)
	Global.UI.get_node("right_panel").hide()
	
func p_begin():
	
	_mp = GameState._mp
	klick = GameState.klick
	if _init_closed:
		if Math._is_on_map(_mp,Global.Level.map_size,Global.Level.tile_size):
			Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(32,0),Vector2(32,32)))
			if Global.Level.content_has(floor(_mp.x/64),floor(_mp.y/64),"Road"):
				if Global.Level.get_node("Roads").get_cellv((_mp/64).floor()) == 0 and\
				Global.Level.content_has_any(floor(_mp.x/64),floor(_mp.y/64)+1,["House","Trees","River"]) == false and \
				Global.Level.content_has_any(floor(_mp.x/64),floor(_mp.y/64)-1,["House","Trees","River"]) == false:
					Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
					if typeof(klick[0])==TYPE_STRING and klick[0] == "l":
						Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)+1])
						Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)-1])
						GameState.append_state("popup_content_menu")
						GameState.free_state("begin")
				elif Global.Level.get_node("Roads").get_cell((_mp/64).floor().x,(_mp/64).floor().y) == 1 and \
				Global.Level.content_has_any(floor(_mp.x/64)+1,floor(_mp.y/64),["House","Trees","River"]) == false and \
				Global.Level.content_has_any(floor(_mp.x/64)-1,floor(_mp.y/64),["House","Trees","River"]) == false:
					Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
					if typeof(klick[0])==TYPE_STRING and klick[0] == "l":
						Economy.add_entitie("House",[floor(_mp.x/64)+1,floor(_mp.y/64)])
						Economy.add_entitie("House",[floor(_mp.x/64)-1,floor(_mp.y/64)])
						GameState.append_state("popup_content_menu")
						GameState.free_state("begin")

func e_begin():
	
	Global.Helpers.del_map_helper("start_helper")
	Global.Popups.get_node("start_mssg").free()
	Global.UI.get_node("Stats/NextTurn").set_disabled(false)
	Global.UI.get_node("right_panel").show()

var _init_closed = false

func _on_Init_close():
	
	_init_closed = true
	Global.Helpers.add_map_helper("start_helper",preload("res://UI/map_icons/map_icons.png"),true,Rect2(Vector2(0,0),Vector2(32,32)))
	var _s =\
	"""Chose your start location. It must be:
\t- straight road
\t- no Forests on sides
Valid location will be marked as green square."""
	Global.Popups.create_tooltip("start_mssg")
	Global.Popups.get_node("start_mssg").set_pos(Vector2(50,50))
	Global.Popups.get_node("start_mssg").width = 305
	Global.Popups.get_node("start_mssg").set_text(_s)
