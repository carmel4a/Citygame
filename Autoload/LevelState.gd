extends Node

var _update_helper = [false,"",0]
	
func _process(delta):
	
	_process_adding()

# array of [x,y,where,what]
func add_cell(c=[[]]):
	
	Global.Level._add(c)
# Shows helper of entitie (MUST be in tiileset) and start processing input
# in order to add that.
func adding_to_map(where,what,sys_name):
	
	Global.Level.get_node("Helpers").add_map_helper("adding_helper",Global.Level.get_node(where).get_tileset().tile_get_texture(what),true,Global.Level.get_node(where).get_tileset().tile_get_region(what),Global.Level.get_node(where).get_scale())
	_update_helper = [true,where,sys_name]
	set_process(true)
	set_process_unhandled_input(true)
# process input
func _process_adding():
	if klick:
		if klick == "l":
			if Economy.add_entitie(_update_helper[2],\
			[floor(Global.Game.get_global_mouse_pos().x/Global.Level.tile_size),\
			floor(Global.Game.get_global_mouse_pos().y/Global.Level.tile_size)]):
				_update_helper = [false,"",0]
				set_process(false)
				set_process_unhandled_input(false)
				klick=false
				Global.Level.get_node("Helpers").del_map_helper("adding_helper")
				Signals.emit("adding_to_map")
		
		elif klick == "r":
				_update_helper = [false,"",0]
				set_process(false)
				set_process_unhandled_input(false)
				klick=false
				Global.Level.get_node("Helpers").del_map_helper("adding_helper")
				Signals.emit("Cancel")
var klick = false
func _unhandled_input(event):
	
	if event.type==InputEvent.MOUSE_BUTTON:
		if event.is_pressed() == true and event.button_index==1:
			klick = "l"
			get_tree().set_input_as_handled()
		elif event.is_pressed() == true and event.button_index==2:
			klick = "r"
			get_tree().set_input_as_handled()
		else:
			klick = false
		