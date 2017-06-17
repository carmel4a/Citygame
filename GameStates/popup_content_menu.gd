extends Node

var klick = GameState.klick
var _lmp = GameState._lmp
var _mp = GameState._mp

func popup_content_menu():
	
	Global.Popups.create_tooltip("tooltip_man")
	Global.Popups.get_node("tooltip_man").hide()
	var _hm = PopupMenu.new()
	_hm.set_name("obj_lst")
	_hm.connect("item_pressed",self,"_pass_bbc")
	_hm.connect("about_to_show",self,"_pop_menu_opened")
	Global.HUD.add_child(_hm)

func p_popup_content_menu():
	
	klick = GameState.klick
	_lmp = GameState._lmp
	_mp = GameState._mp
	if typeof(klick[0]) == 4:
		if klick[0] == "l":
			if Global.HUD.get_node("obj_lst").is_hidden():
				Global.HUD.get_node("obj_lst").clear()
				Global.HUD.get_node("obj_lst").set_pos(_lmp.floor())
				for i in Global.content(Vector2(_mp/64).floor()):
					if i.values()[0].get("tooltip") != null:
						Global.HUD.get_node("obj_lst").add_item(i.keys()[0])
				Global.HUD.get_node("obj_lst").add_item("Range")
				Global.HUD.get_node("obj_lst").add_item("Res")
				Global.HUD.get_node("obj_lst").popup()
			else:
				Global.HUD.get_node("obj_lst").hide()
			if !Global.Popups.get_node("tooltip_man").is_hidden():
				Global.Popups.get_node("tooltip_man").hide()
				Global.Popups.get_node("tooltip_man").clear()
		if klick[0] == "r":
			Global.HUD.get_node("obj_lst").hide()
			Global.Popups.get_node("tooltip_man").hide()

func e_popup_content_menu():
	Global.Popups.get_node("tooltip_man").free()
	Global.HUD.get_node("obj_lst").free()

func _pass_bbc(i):
	
	if Global.HUD.get_node("obj_lst").get_item_text(i)=="Res":
		var _p = Global.Helpers.get_range((_klicked/64).floor().x,(_klicked/64).floor().y,4)
		var wood = 0
		var __tex = preload("res://UI/map_icons/res.png")
		for i in _p[0]:
			if Global.Level.content_has(i.x,i.y,"Trees"):
				wood += Global.Level.content_get(i.x,i.y,"Trees").wood
				Global.Helpers.light_static_helper_v2(__tex,Vector2(2,2),i*64)
		Global.Popups.get_node("tooltip_man").set_text("wood: "+str(wood))
		Global.Popups.get_node("tooltip_man").set_pos(get_viewport().get_mouse_pos())
		Global.Popups.get_node("tooltip_man").show()
	elif Global.HUD.get_node("obj_lst").get_item_text(i)=="Range":
		var _p = Global.Helpers.get_range((_klicked/64).floor().x,(_klicked/64).floor().y,4)
#		var __L = Label.new()
#		__L.set_pos(i*64+Vector2(32,32))
#		__L.set_text(str(__checked[1][__checked[0].find(i)]))
#		add_child(__L)
		var __tex = preload("res://UI/map_icons/res.png")
		for i in _p[0]:
			Global.Helpers.light_static_helper_v2(__tex,Vector2(2,2),i*64)
	else:
		Global.Popups.get_node("tooltip_man").show()
		if Global.content((_klicked/64).floor())[i].values()[0].get("tooltip") != null:
			Global.Popups.get_node("tooltip_man").set_text(Global.content((_klicked/64).floor())[i].values()[0].get("tooltip"))
			Global.Popups.get_node("tooltip_man").show()
			Global.Popups.get_node("tooltip_man").set_pos(_lmp)
var _klicked
func _pop_menu_opened():
	
	_klicked = _mp
