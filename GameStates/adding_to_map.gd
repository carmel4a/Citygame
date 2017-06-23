extends Node

var _update_helper = [false,"",0]
var something = GameState.something # to get something form game state e.g. mouse pos
var klick = GameState.klick[0]
func adding_to_map(where,what,sys_name): #setup game state
	
	Global.Level.get_node("Helpers").add_map_helper("adding_helper",Global.Level.get_node(where).get_tileset().tile_get_texture(what),true,Global.Level.get_node(where).get_tileset().tile_get_region(what),Global.Level.get_node(where).get_scale())
	_update_helper = [true,where,sys_name]

func p_adding_to_map(): # in-game process of game state. Here should be conditions to
	
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
	
func e_adding_to_map(): # called when quiting the state. Here should be set up 
	pass			# new state(s) by GameState.append_state() if any. If that was
					# last state, and no new state was passed, next state will be [idle]
