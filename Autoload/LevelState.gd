extends Node

var _update_helper = [false,"",0]
	
func _process(delta):
	
	_process_adding()
	
func _process_adding():
	
	if _update_helper[1]:
		Global.Level.get_node("Helper").set_pos((Global.Game.get_global_mouse_pos()/Global.Level.tile_size)*Global.Level.tile_size)
	if Input.is_mouse_button_pressed(1):
		if Global.build(floor(Global.Game.get_global_mouse_pos().x/Global.Level.tile_size),\
		floor(Global.Game.get_global_mouse_pos().y/Global.Level.tile_size),_update_helper[2]):
			_update_helper = [false,"",0]
			set_process(false)
			Global.delete_helper()
		
	if Input.is_mouse_button_pressed(2):
			_update_helper = [false,"",0]
			set_process(false)
			Global.delete_helper()
# array of [x,y,where,what]
func add_cell(c=[[]]):
	
	Global.Level._add(c)
	
func adding_to_map(where,what,sys_name):
	
	Global.show_helper(where,what)
	_update_helper = [true,where,sys_name]
	set_process(true)
	