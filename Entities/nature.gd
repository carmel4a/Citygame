extends Node

class Grass:
	var _done = false
	func init(xy):
		
		var x = xy[0]
		var y = xy[1]
		
		var _r = randf()
		if _r > 0.75:
			LevelState.add_cell([[x,y,"Grass",0]])
		elif _r > 0.5:
			LevelState.add_cell([[x,y,"Grass",1]])
		elif _r > 0.05:
			LevelState.add_cell([[x,y,"Grass",2]])
		else:
			LevelState.add_cell([[x,y,"Grass",3]])
		_done = true

	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)

class River:
	var _done = false
	func init(xy):
		
		var x = xy[0]
		var y = xy[1]
		
		LevelState.add_cell([[x,y,"Water",0]])
		_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)

class Trees:
	var _done = false
	func init(xy):
		
		var x = xy[0]
		var y = xy[1]
		
		LevelState.add_cell([[x,y,"Trees",0]])
		_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
