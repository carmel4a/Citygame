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
actualize = true):
	# check if actually have that
	for i in get_children():
		if i.get_name()==name:
			print("ERROR: Have that helper: "+name)
			return (false)
	var _s = Sprite.new()
	_s.set_texture(tex)
	_s.set_region(region)
	_s.set_region_rect(region_rect)
	_s.set_scale(scale)
	_s.set_name(name)
	add_child(_s)
	follow_mouse.append(name)
	if actualize:
		set_process(true)

func del_map_helper(name):
	
	get_node(name).free()
	follow_mouse.erase(name)
	if follow_mouse.size() == 0:
		set_process(false)

func _process(delta):
	
	var _mp = get_global_mouse_pos()
	for i in follow_mouse:
		# don't ask/don't touch
		get_node(i).set_global_pos((_mp/(get_node(i).get_item_rect().size*get_node(i).get_scale())).floor()*(get_node(i).get_item_rect().size*get_node(i).get_scale())+get_node(i).get_item_rect().size)
