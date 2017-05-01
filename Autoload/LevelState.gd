extends Node

# array of [x,y,where,what]
func add_cell(c=[[]]):
	Global.Level._add(c)
	
func adding_to_map(where,what):
	Global.show_helper(where,what)
	Global._update_helper = [true,where,what]
	Global.set_process(true)