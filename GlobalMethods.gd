extends Node

onready var Game = get_node("/root/Game")
onready var UI = get_node("/root/Game/CanvasLayer/UI")
onready var Level = get_node("/root/Game/Level")

var _update_helper = [false,"",0]

func _process(delta):
	
	if _update_helper[1]:
		Level.get_node("Helper").set_pos((Game.get_global_mouse_pos()/32).floor()*32)

func get_turn_no():
	
	return(Game.Turn)
	
func set_IP(v):
	
	UI._update(["Stats/Label"])
	Game.acc_IP = v

func get_IP():
	
	return(Game.acc_IP)

func get_IP_diff():
	
	return(Game.dif_IP)

func set_IP_diff(v):
	
	UI._update(["Stats/Label"])
	Game.dif_IP = v

# x,y,where,what
func add_cell(c=[]):
	Level._add(c)
	
func show_helper(where,what):
	
	var _h = Sprite.new()
	var _i = false
	for i in Level.get_children():
		if i.get_name() == "Helper":
			_i = true
			break
	if !_i:
		_h.set_texture(Level.get_node(where).get_tileset().tile_get_texture(what))
		_h.set_name("Helper")
		_h.set_scale(Level.get_node(where).get_scale())
		Level.add_child(_h)
	
func delete_helper():
	var _i = false
	for i in Level.get_children():
		if i.get_name() == "Helper":
			i.free()
			break

func adding_to_map(where,what):
	show_helper(where,what)
	_update_helper = [true,where,what]
	set_process(true)

func build_a_house(x,y):
	if !Level._content[x][y].has("House"):
		Level._content[x][y].append("House")
		add_cell([[x,y,"items",0]])