extends Node

onready var Game = get_node("/root/Game")
onready var UI = get_node("/root/Game/HUD/UI")
onready var Level = get_node("/root/Game/Level")

var _update_helper = [false,"",0]

func _process(delta):
	
	if _update_helper[1]:
		Level.get_node("Helper").set_pos((Game.get_global_mouse_pos()/32).floor()*32)

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

func build_a_house(x,y):
	if !Level._content[x][y].has("House"):
		Level._content[x][y].append("House")
		LevelState.add_cell([[x,y,"Items",0]])