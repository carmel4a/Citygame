extends Node

class Grass:
	var _done = false
	var tooltip = "A Grassland"
	func init(xy):
		
		var x = xy[0]
		var y = xy[1]
		if !Global.Level.content_has(x,y,"Grass"):
			Global.content(Vector2(x,y)).append({"Grass":self})
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
		if !Global.Level.content_has(x,y,"River"):
			Global.content(Vector2(x,y)).append({"River":self})
			LevelState.add_cell([[x,y,"Water",0]])
			_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)

class Trees:
	var _done = false
	var wood = 10
	var true_age
	var age = -1
	var age_names = ["young","medium","old"]
	var tooltip =\
"""Wood: %d
Age: %s"""
	func init(xy):
		
		var x = xy[0]
		var y = xy[1]
		if !Global.Level.content_has(x,y,"Trees"):
			Global.content(Vector2(x,y)).append({"Trees":self})
			LevelState.add_cell([[x,y,"Trees",0]])
			Global.Game.connect("next_turn",self,"next_turn")
			_done = true
			
	func _ready():
		
		if _done:
			next_turn()
			return(true)
		else:
			return(false)
	
	func next_turn():
		if age != 2:
			age += 1
		tooltip =\
		"""Wood: %d
Age: %s""" % [wood,age_names[age]]
