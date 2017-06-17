extends Node2D
# an array with names of helper's nodes which are moving with mouse.
var follow_mouse = []
# add and show map "helper"/"shadow" - a sprite which may move with mouse (with mouse)
func add_map_helper(\
name,\
tex,\
region = false,\
region_rect = Rect2(Vector2(0,0),Vector2(0,0)),\
scale = Vector2(2,2),\
actualize = true,\
pos = Vector2(0,0)):
	# check if actually have that
	if name == null:
		name = "Helper"
	for i in get_children():
		if i.get_name()==name and name != "Helper":
			print("ERROR: Have that helper: "+name)
			return (false)
	var _s = Sprite.new()
	_s.set_texture(tex)
	_s.set_region(region)
	_s.set_region_rect(region_rect)
	_s.set_scale(scale)
	_s.set_name(name)
	if !actualize:
		var size = _s.get_item_rect().size
		#just don't ask
		_s.set_global_pos((pos/(size*scale)).floor()*(size*scale)+size)
	add_child(_s,true)
	if actualize:
		follow_mouse.append(name)
		set_process(true)
var _light_helpers = []
func light_static_helper(\
	tex,\
	region = false,\
	region_rect = Rect2(Vector2(0,0),Vector2(0,0)),\
	scale = Vector2(2,2),\
	pos = Vector2(0,0)):
	var _s = Sprite.new()
	_s.set_texture(tex)
	_s.set_region(region)
	if region:
		_s.set_region_rect(region_rect)
	_s.set_scale(scale)
	var size = _s.get_item_rect().size
	_s.set_global_pos((pos/(size*scale)).floor()*(size*scale)+size)
	_light_helpers.append(_s)
	add_child(_s)

func light_static_helper_v2(\
	tex,\
	scale = Vector2(2,2),\
	pos = Vector2(0,0)):
	var _s = Sprite.new()
	_s.set_texture(tex)
	_s.set_scale(scale)
	var size = _s.get_item_rect().size
	_s.set_global_pos((pos/(size*scale)).floor()*(size*scale)+size)
	_light_helpers.append(_s)
	add_child(_s)
func del_map_helper(name):
	
	get_node(name).free()
	follow_mouse.erase(name)
	if follow_mouse.size() == 0:
		set_process(false)
func delete_light_helpers():
	for i in _light_helpers:
		i.free()
	_light_helpers.clear()
func _process(delta):
	
	var _mp = get_global_mouse_pos()
	for i in follow_mouse:
		# don't ask/don't touch
		var _size = get_node(i).get_item_rect().size
		var _scale = get_node(i).get_scale()
		get_node(i).set_global_pos((_mp/(_size*_scale)).floor()*(_size*_scale)+_size)

var __checked = [[],[]]
var to_check = [[],[]]
func get_range(x,y,MP):
	
	__checked = [[],[]]
	to_check = [[Vector2(x,y)],[MP]]
	while !to_check[0].empty():
		var i = to_check[0][0]
		_add_checks(i.x,i.y,to_check[1][to_check[0].find(i)])
	return(__checked)

var __dirs=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)]
func _add_checks(x,y,MP):
	
	if !__checked[0].has(Vector2(x,y)) or\
	(__checked[0].has(Vector2(x,y)) and\
	__checked[1][__checked[0].find(Vector2(x,y))] <= MP and MP >=0):
		for i in __dirs:
			var _checking = Vector2(x,y)+i
			if Rect2(Vector2(0,0),Global.Level.map_size).has_point(_checking):
				var _mpd = 1
				if Global.Level.content_has(_checking.x,_checking.y,"Road"):
					_mpd = 0.1
				elif Global.Level.content_has(_checking.x,_checking.y,"Trees"):
					_mpd = 2
				elif Global.Level.content_has(_checking.x,_checking.y,"River"):
					_mpd = null
				
				if !__checked[0].has(_checking) and _mpd != null and MP -_mpd >= 0:
					to_check[0].append(_checking)
					to_check[1].append(MP-_mpd)
				if __checked[0].has(_checking) and __checked[1][__checked[0].find(_checking)]<MP-_mpd and MP-_mpd >=0:
					__checked[1][__checked[0].find(_checking)] = MP-_mpd
					to_check[0].append(_checking)
					to_check[1].append(MP-_mpd)
		if !__checked[0].has(Vector2(x,y)) and to_check[1][to_check[0].find(Vector2(x,y))] >=0:
			__checked[0].append(Vector2(x,y))
			__checked[1].append(to_check[1][to_check[0].find(Vector2(x,y))])
		else:
			if MP >=0:
				__checked[1][__checked[0].find(Vector2(x,y))] = MP
	to_check[1].remove(to_check[0].find(Vector2(x,y)))
	to_check[0].remove(to_check[0].find(Vector2(x,y)))
