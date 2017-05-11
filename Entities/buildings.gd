extends Node

class House:\

	var _done = false
	
	func init(xy):
		var x = xy[0]
		var y = xy[1]
		if !Global.Level._content[x][y].has("House") and\
		!Global.Level._content[x][y].has("Trees") and\
		!Global.Level._content[x][y].has("Road") and\
		!Global.Level._content[x][y].has("River"):
			Global.Level._content[x][y].append("House")
			LevelState.add_cell([[x,y,"Items",0]])
			_done = true

	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
