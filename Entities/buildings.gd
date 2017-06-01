extends Node

class House:

	var _done = false
	var _pop = [0,0,0]
	var tooltip = "Population: %d/%d" % [0,0]
	func init(xy):
		var x = xy[0]
		var y = xy[1]
		if Global.Level.content_has_any(x,y,["House","Trees","Road","River"]) ==false:
			Global.content(Vector2(x,y)).append({"House":self})
			LevelState.add_cell([[x,y,"Items",0]])
			self._pop = [2,10,1]
			GameState.pop[0]+=_pop[0]
			GameState.pop[1]+=_pop[1]
			GameState.pop[2]+=_pop[2]
			
			tooltip =\
			"Population: %d/%d" % [_pop[0],_pop[1]]
			
			Signals.connect("next_turn",self,"next_turn")
			_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
	
	func next_turn():
		var _r = int(round(rand_range(0,1)))
		if int(_pop[0]) >= int(_pop[1]):
			_r = round(int(_r)-1)
		GameState.pop[0] = int(GameState.pop[0]) + int(_pop[2])
		_pop[0] = int(_pop[0]) + int(_pop[2])
		GameState.pop[2] = int(GameState.pop[2]) + int(_r)
		_pop[2] = int(_r)
		tooltip =\
		"Population: %d/%d" % [int(_pop[0]),int(_pop[1])]
