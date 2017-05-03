extends Node
var _update_helper = [false,"",0]
	
func _process(delta):
	if _update_helper[1]:
		Global.Level.get_node("Helper").set_pos((Global.Game.get_global_mouse_pos()/Global.Level.tile_size)*Global.Level.tile_size)
	if Input.is_mouse_button_pressed(1):
		Global.build_a_house(floor(Global.Game.get_global_mouse_pos().x/Global.Level.tile_size),\
		floor(Global.Game.get_global_mouse_pos().y/Global.Level.tile_size))
		
	if Input.is_mouse_button_pressed(2):
		Global.bulid_a_road(floor(Global.Game.get_global_mouse_pos().x/Global.Level.tile_size),\
		floor(Global.Game.get_global_mouse_pos().y/Global.Level.tile_size))
# array of [x,y,where,what]
func add_cell(c=[[]]):
	Global.Level._add(c)
	
func adding_to_map(where,what):
	Global.show_helper(where,what)
	_update_helper = [true,where,what]
	set_process(true)
	