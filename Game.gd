extends Node2D

# Seed
export(int) var vseed = -1

var _bef_ng = true #ng - new game

func new_game():
	
	vseed = randi()
	seed(vseed)
	var _l = preload("res://Tooltip/Tooltip.tscn").instance()
	_l.set_name("start_label")
	Global.Level.get_node("Helpers").add_map_helper("start_helper",preload("res://UI/map_icons/map_icons.png"),true,Rect2(Vector2(0,0),Vector2(32,32)))
	get_node("HUD").add_child(_l)
	get_node("HUD/start_label").set_pos(Vector2(50,50))
	get_node("HUD/start_label/RTLabel").add_text("Choose start location.")
	get_node("HUD/start_label/RTLabel").add_image(preload("res://UI/map_icons/map_icons.png"))
	set_process(true)

func _enter_tree():
	
	if vseed == -1:
		randomize()
		vseed = randi()
	seed(vseed)

func _ready():
	
	new_game()

func _process(delta):
	
	var _mp = get_global_mouse_pos()
	Global.Level.get_node("Helpers/start_helper").set_region_rect(Rect2(Vector2(32,0),Vector2(32,32)))
	if _bef_ng == true:
		if Global.content(Vector2(_mp/64).floor()).has("Road"):
			if Global.Level.get_node("Roads").get_cell((_mp/64).floor().x,(_mp/64).floor().y) == 0 and\
			!Global.content((_mp/64).floor()+Vector2(0,1)).has("House") and \
			!Global.content((_mp/64).floor()+Vector2(0,1)).has("Trees") and \
			!Global.content((_mp/64).floor()-Vector2(0,1)).has("House") and \
			!Global.content((_mp/64).floor()-Vector2(0,1)).has("Trees"):
				Global.Level.get_node("Helpers/start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
				if Input.is_mouse_button_pressed(1):
					Global.build_a_house(floor(_mp.x/64),floor(_mp.y/64)+1)
					Global.build_a_house(floor(_mp.x/64),floor(_mp.y/64)-1)
					_bef_ng = false
					set_process(false)
					get_node("HUD/start_label").free()
					Global.Level.get_node("Helpers").del_map_helper("start_helper")
			elif Global.Level.get_node("Roads").get_cell((_mp/64).floor().x,(_mp/64).floor().y) == 1 and \
			!Global.content((_mp/64).floor()+Vector2(1,0)).has("House") and \
			!Global.content((_mp/64).floor()+Vector2(1,0)).has("Trees") and \
			!Global.content((_mp/64).floor()-Vector2(1,0)).has("House") and \
			!Global.content((_mp/64).floor()-Vector2(1,0)).has("Trees"):
				Global.Level.get_node("Helpers/start_helper").set_region_rect(Rect2(Vector2(0,0),Vector2(32,32)))
				if Input.is_mouse_button_pressed(1):
					Economy.add_entitie("House",[floor(_mp.x/64)+1,floor(_mp.y/64)])
					Economy.add_entitie("House",[floor(_mp.x/64)-1,floor(_mp.y/64)])

					_bef_ng = false
					set_process(false)
					Global.Level.get_node("Helpers").del_map_helper("start_helper")
					get_node("HUD/start_label").free()

func _next_turn():
	
	GameState._Turn += 1
	GameState.set_Auth(GameState._Auth + GameState._d_Auth)
	Popups.generate_turn_alerts()
