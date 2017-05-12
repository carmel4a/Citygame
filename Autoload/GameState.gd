extends Node

var _Turn = 0
# authority
var _Auth  = 10
# difference of authority per turn
var _d_Auth = 5
var pop = [] # acc, delta, max

var _state = "begin"

var _bef_ng = true #ng - new game

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
		call(_state)
	else:
		set_process(false)

func _process(delta):
	
	call(str("p_"+_state))

func begin():
	
	Global.Helpers.add_map_helper("start_helper",preload("res://UI/map_icons/map_icons.png"),true,Rect2(Vector2(0,0),Vector2(32,32)))
	Popups.tooltip("start_mssg")
	Global.HUD.get_node("start_mssg").set_pos(Vector2(50,50))
	Global.HUD.get_node("start_mssg").RTL.add_text("Choose start location.")
	Global.HUD.get_node("start_mssg").RTL.add_image(preload("res://UI/map_icons/map_icons.png"))

func p_begin():
	
	var _mp = Global.Game.get_global_mouse_pos()
	Global.Level.get_node("Helpers/start_helper").set_region_rect(Rect2(Vector2(32,0),Vector2(32,32)))
	if _bef_ng == true:
		if Global.content(Vector2(_mp/64).floor()).has("Road"):

			if Global.Level.get_node("Roads").get_cellv((_mp/64).floor()) == 0 and\
			!Global.content((_mp/64).floor()+Vector2(0,1)).has("House") and \
			!Global.content((_mp/64).floor()+Vector2(0,1)).has("Trees") and \
			!Global.content((_mp/64).floor()-Vector2(0,1)).has("House") and \
			!Global.content((_mp/64).floor()-Vector2(0,1)).has("Trees"):
				Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
				if Input.is_mouse_button_pressed(1):
					Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)+1])
					Economy.add_entitie("House",[floor(_mp.x/64),floor(_mp.y/64)-1])
					_bef_ng = false
					set_process(false)
					Global.HUD.get_node("start_mssg").free()
					Global.Helpers.del_map_helper("start_helper")
					Global.UI.get_node("Stats/NextTurn").set_disabled(false)
					set_state("idle")
			elif Global.Level.get_node("Roads").get_cell((_mp/64).floor().x,(_mp/64).floor().y) == 1 and \
			!Global.content((_mp/64).floor()+Vector2(1,0)).has("House") and \
			!Global.content((_mp/64).floor()+Vector2(1,0)).has("Trees") and \
			!Global.content((_mp/64).floor()-Vector2(1,0)).has("House") and \
			!Global.content((_mp/64).floor()-Vector2(1,0)).has("Trees"):
				Global.Helpers.get_node("start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
				if Input.is_mouse_button_pressed(1):
					Economy.add_entitie("House",[floor(_mp.x/64)+1,floor(_mp.y/64)])
					Economy.add_entitie("House",[floor(_mp.x/64)-1,floor(_mp.y/64)])
					_bef_ng = false
					set_process(false)
					Global.Level.get_node("Helpers").del_map_helper("start_helper")
					Global.HUD.get_node("start_mssg").free()
					Global.UI.get_node("Stats/NextTurn").set_disabled(false)
					set_state("idle")
