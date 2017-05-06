extends Node2D

var follow_mouse = []

func add_map_helper(name, actualize = true):
	
	var _s = Sprite.new()
	#swich for names?
	_s.set_texture(preload("res://UI/map_icons/map_icons.png"))
	_s.set_region(true)
	_s.set_region_rect(Rect2(Vector2(32,0),Vector2(32,32)))
	_s.set_scale(Vector2(2,2))
	_s.set_name(name)
	add_child(_s)
	follow_mouse.append(name)
	if actualize:
		set_process(true)

func del_map_helper(name):
#	print(name)
	for i in get_children():
		print(i.get_name())
	get_node(name).free()
	follow_mouse.erase(name)
	if follow_mouse.size() == 0:
		set_process(false)

func _process(delta):
	
	var _mp = Global.Game.get_global_mouse_pos()
	for i in follow_mouse:
			get_node("start_helper").set_global_pos(Vector2((_mp/64).floor()*64+Vector2(32,32)))
