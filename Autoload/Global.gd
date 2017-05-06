extends Node

onready var Game = get_node("/root/Game")
onready var UI = get_node("/root/Game/HUD/UI")
onready var Level = get_node("/root/Game/Level")

func content(v):
	
	return(Level._content[v.x][v.y])

func _ready():
	
	add_user_signal("done")

func done():
	
	emit_signal("done")

func show_helper(where,what):
	
	var _h = Sprite.new()
	var _i = false
	for i in Level.get_children():
		if i.get_name() == "Helper":
			_i = true
			break
	if !_i:
		_h.set_texture(Level.get_node(where).get_tileset().tile_get_texture(what))
		_h.set_region(true)
		_h.set_region_rect(Level.get_node(where).get_tileset().tile_get_region(what))
		_h.set_name("Helper")
		_h.set_scale(Level.get_node(where).get_scale())
		Level.add_child(_h)
	
func delete_helper():
	var _i = false
	for i in Level.get_children():
		if i.get_name() == "Helper":
			i.free()
			break
func update_road(x,y):
	var _s = [false,false,false,false]
	if x > 0:
		if Level._content[x-1][y].has("Road"):
			_s[0] = true
	if y > 0:
		if Level._content[x][y-1].has("Road"):
			_s[1] = true
	if x+1 < Level._content.size():
		if Level._content[x+1][y].has("Road"):
			_s[2] = true
	if x < Level._content.size() and y+1 < Level._content[x].size():
		if Level._content[x][y+1].has("Road"):
			_s[3] = true
	LevelState.add_cell([[x,y,"Roads",6]])
	if _s[0] or _s[2]:
		LevelState.add_cell([[x,y,"Roads",0]])
	if _s[1] or _s[3]:
		LevelState.add_cell([[x,y,"Roads",1]])
		
	if (_s[0] and _s[1]):
		LevelState.add_cell([[x,y,"Roads",7]])
	if (_s[2] and _s[1]):
		LevelState.add_cell([[x,y,"Roads",12]])
	if (_s[0] and _s[3]):
		LevelState.add_cell([[x,y,"Roads",11]])
	if (_s[2] and _s[3]):
		LevelState.add_cell([[x,y,"Roads",9]])

	if _s[0] and _s[1] and _s[3] :
		LevelState.add_cell([[x,y,"Roads",2]])
	if _s[2] and _s[1] and _s[3]:
		LevelState.add_cell([[x,y,"Roads",3]])
	if _s[2] and _s[0] and _s[3]:
		LevelState.add_cell([[x,y,"Roads",4]])
	if _s[1] and _s[0] and _s[2]:
		LevelState.add_cell([[x,y,"Roads",5]])
	if _s[0] and _s[1] and _s[2] and _s[3]:
		LevelState.add_cell([[x,y,"Roads",6]])
func bulid_a_road(x,y):
	if !Level._content[x][y].has("Road") and\
	!Level._content[x][y].has("Trees") and\
	!Level._content[x][y].has("River"):
		Level._content[x][y].append("Road")
		update_road(x,y)
		var _s = [false,false,false,false]
		if x > 0:
			if Level._content[x-1][y].has("Road"):
				_s[0] = true
		if y > 0:
			if Level._content[x][y-1].has("Road"):
				_s[1] = true
		if x+1 < Level._content.size():
			if Level._content[x+1][y].has("Road"):
				_s[2] = true
		if x < Level._content.size() and y+1 < Level._content[x].size():
			if Level._content[x][y+1].has("Road"):
				_s[3] = true
		if _s[0]:
			update_road(x-1,y)
		if _s[1]:
			update_road(x,y-1)
		if _s[2]:
			update_road(x+1,y)
		if _s[3]:
			update_road(x,y+1)
		return(true)
	return(false)

func build_a_house(x,y):
	if !Level._content[x][y].has("House") and\
	!Level._content[x][y].has("Trees") and\
	!Level._content[x][y].has("River"):
		Level._content[x][y].append("House")
		LevelState.add_cell([[x,y,"Items",0]])
		return(true)
	return(false)
	
func build(x,y,what):
	if what == "Road": 
		call_deferred("done")
		return(bulid_a_road(x,y))
		
	if what == "House": 
		call_deferred("done")
		return(build_a_house(x,y))
