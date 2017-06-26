extends Node

var click = GameState.klick
var _lmp = Vector2(0,0)
var _mp = GameState._mp
var _clicked
func popup_content_menu():
	
	Global.Popups.create_tooltip("tooltip_man")
	Global.Popups.get_node("tooltip_man").hide()
	var _pm = PopupMenu.new()
	_pm.connect("about_to_show",self,"_pop_menu_opened")
	_pm.connect("item_pressed",self,"_pass_bbc")
	_pm.set_name("obj_lst")
	Global.HUD.add_child(_pm,true)

func p_popup_content_menu():
	
	GameState.load_state()
	click = GameState.klick
	_lmp = GameState._lmp
	_mp = GameState._mp
	if typeof(click[0]) == TYPE_STRING and\
	Global.HUD.has_node("obj_lst") and\
	Global.Popups.has_node("tooltip_man"):
		if click[0] == "l" and Math._is_on_map(_mp,Global.Level.map_size,Global.Level.tile_size):
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
		elif click[0] == "r" and Math._is_on_map(click[1],Global.Level.map_size,Global.Level.tile_size):
			Global.HUD.get_node("obj_lst").hide()
			Global.Popups.get_node("tooltip_man").hide()

func e_popup_content_menu():
	
	Global.Popups.get_node("tooltip_man").free()
	Global.HUD.get_node("obj_lst").free()
	GameState.save_state({})

func _pass_bbc(id):
	
	if Global.HUD.get_node("obj_lst").get_item_text(id)=="Res":
		var _p = Global.Helpers.get_range((_clicked/64).floor().x,(_clicked/64).floor().y,4)
		var wood = 0
		var __tex = preload("res://UI/map_icons/res.png")
		Global.Helpers.delete_light_helpers()
		for i in _p[0]:
			if Global.Level.content_has(i.x,i.y,"Trees"):
				wood += Global.Level.content_get(i.x,i.y,"Trees").wood
				Global.Helpers.light_static_helper_v2(__tex,Vector2(2,2),i*64)
		Global.Popups.get_node("tooltip_man").set_text("wood: "+str(wood))
		Global.Popups.get_node("tooltip_man").set_pos(get_viewport().get_mouse_pos())
		Global.Popups.get_node("tooltip_man").show()
	elif Global.HUD.get_node("obj_lst").get_item_text(id)=="Range":
		var _p = Global.Helpers.get_range((_clicked/64).floor().x,(_clicked/64).floor().y,4)
#		var __L = Label.new()
#		__L.set_pos(i*64+Vector2(32,32))
#		__L.set_text(str(__checked[1][__checked[0].find(i)]))
#		add_child(__L)
		var __tex = preload("res://UI/map_icons/res.png")
		Global.Helpers.delete_light_helpers()
		for i in _p[0]:
			Global.Helpers.light_static_helper_v2(__tex,Vector2(2,2),i*64)
	else:
		Global.Popups.get_node("tooltip_man").show()
		var _real = 0
		var _mach = 0
		for i in Global.content(Vector2(_clicked/64).floor()):
			if _mach == id: break
			if i.values()[0].get("tooltip") != null:
				_mach += 1
			_real += 1
		if Global.content((_clicked/64).floor())[_real].values()[0].get("tooltip") != null:
			Global.Popups.get_node("tooltip_man").set_text(Global.content((_clicked/64).floor())[_real].values()[0].get("tooltip"))
			Global.Popups.get_node("tooltip_man").show()
			Global.Popups.get_node("tooltip_man").set_pos(_lmp)

func _pop_menu_opened():
	
	_clicked = _mp
#	_clicked = click[1]
	GameState.save_state({"_clicked":_clicked})
