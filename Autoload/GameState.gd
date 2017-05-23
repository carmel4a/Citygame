extends Node

var _Turn = 0
# authority
var _Auth  = 10
# difference of authority per turn
var _d_Auth = 5
var pop = [] # acc, delta, max

var _state = "begin" setget set_state
var klick = [false,Vector2(-1,-1)]
var _mp
var _lmp
func set_Auth_diff(v):
	
	_d_Auth = v
	Global.UI._update(["Stats/Label"])

func set_Auth(v):
	
	_Auth = v
	Global.UI._update(["Stats/Label"])

func set_state(_s):
	
	_state = _s
	if _s != "idle":
		set_process(true)
		set_process_unhandled_input(true)
		call(_state)
	else:
		set_process(false)
		set_process_unhandled_input(false)

func _process(delta):
	_mp = Global.Game.get_global_mouse_pos()
	_lmp = get_tree().get_root().get_mouse_pos()
	call(str("p_"+_state))

func begin():
	
	Global.Helpers.add_map_helper("start_helper",preload("res://UI/map_icons/map_icons.png"),true,Rect2(Vector2(0,0),Vector2(32,32)))
	Popups.tooltip("start_mssg")
	Global.HUD.get_node("start_mssg").set_pos(Vector2(50,50))
	Global.HUD.get_node("start_mssg").RTL.add_text("Choose start location.")
	Global.HUD.get_node("start_mssg").RTL.add_image(preload("res://UI/map_icons/map_icons.png"))

func p_begin():
	
	Global.Helpers.get_node("start_helper").set_pos(_mp/64)
	Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(32,0),Vector2(32,32)))
	if Global.Level.content_has(floor(_mp.x/64),floor(_mp.y/64),"Road"):
		if Global.Level.get_node("Roads").get_cellv((_mp/64).floor()) == 0 and\
		Global.Level.content_has_any(floor(_mp.x/64),floor(_mp.y/64)+1,["House","Trees"]) == false and \
		Global.Level.content_has_any(floor(_mp.x/64),floor(_mp.y/64)-1,["House","Trees"]) == false:
			Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
			if klick[0]:
				Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)+1])
				Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)-1])
				Global.HUD.get_node("start_mssg").free()
				Global.Helpers.del_map_helper("start_helper")
				Global.UI.get_node("Stats/NextTurn").set_disabled(false)
				set_state("in_game")
		elif Global.Level.get_node("Roads").get_cell((_mp/64).floor().x,(_mp/64).floor().y) == 1 and \
		Global.Level.content_has_any(floor(_mp.x/64)+1,floor(_mp.y/64),["House","Trees"]) == false and \
		Global.Level.content_has_any(floor(_mp.x/64)-1,floor(_mp.y/64),["House","Trees"]) == false:
			Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
			if klick[0]:
				Economy.add_entitie("House",[floor(_mp.x/64)+1,floor(_mp.y/64)])
				Economy.add_entitie("House",[floor(_mp.x/64)-1,floor(_mp.y/64)])
				Global.Level.get_node("Helpers").del_map_helper("start_helper")
				Global.HUD.get_node("start_mssg").free()
				Global.UI.get_node("Stats/NextTurn").set_disabled(false)
				yield(get_tree(),"idle_frame")
				set_state("in_game")

func in_game():
	Popups.tooltip("Tooltip")
	Global.HUD.get_node("Tooltip").hide()
	var _hm = PopupMenu.new()
	_hm.set_name("obj_lst")
	_hm.connect("item_pressed",self,"_pass_bbc")
	_hm.connect("about_to_show",self,"_pop_menu_opened")
	Global.HUD.add_child(_hm)

func p_in_game():
	if klick[0]:
		if klick[0] == "l":
			Global.HUD.get_node("obj_lst").clear()
			Global.HUD.get_node("obj_lst").set_pos(_lmp.floor())
			for i in Global.content(Vector2(_mp/64).floor()):
				Global.HUD.get_node("obj_lst").add_item(i.keys()[0])
			Global.HUD.get_node("obj_lst").popup()
			if !Global.HUD.get_node("Tooltip").is_hidden():
				Global.HUD.get_node("Tooltip").hide()
				Global.HUD.get_node("Tooltip").clear()
		if klick[0] == "r":
			Global.HUD.get_node("obj_lst").hide()
			Global.HUD.get_node("Tooltip").hide()
			Global.HUD.get_node("Tooltip").clear()
var _klicked
func _pass_bbc(i):
	Global.HUD.get_node("Tooltip").show()
	if Global.content((_klicked/64).floor())[i].values()[0].get("tooltip") != null:
		Global.HUD.get_node("Tooltip").set_text(Global.content((_klicked/64).floor())[i].values()[0].get("tooltip"))
		Global.HUD.get_node("Tooltip").show_modal()
		Global.HUD.get_node("Tooltip").set_pos(_lmp)

func _pop_menu_opened():
	_klicked = _mp

func _unhandled_input(event):
	
	if event.type==InputEvent.MOUSE_BUTTON:
		if event.is_pressed() == true and event.button_index==1:
			klick[0] = "l"
			klick[1] = event.global_pos
#			get_tree().set_input_as_handled()
		elif event.is_pressed() == true and event.button_index==2:
			klick[0] = "r"
			klick[1] = event.global_pos
#			get_tree().set_input_as_handled()
		else:
			klick[0] = false
			klick[1] = Vector2(-1,-1)

