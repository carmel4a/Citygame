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
