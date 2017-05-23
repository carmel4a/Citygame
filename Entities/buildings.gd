extends Node

class House:

	var _done = false
	var _pop = [0,0]
	onready var tooltip = "Population: %d/%d" % [_pop[0],_pop[1]]
	func init(xy):
		var x = xy[0]
		var y = xy[1]
		_pop = [2,10]
		if Global.Level.content_has_any(x,y,["House","Trees","Road","River"]) ==false:
			Global.content(Vector2(x,y)).append({"House":self})
			LevelState.add_cell([[x,y,"Items",0]])
			
			_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
