extends Node

class House:
	var x
	var y
	var _pop = [0,0,0]
	var _done = false
	var tooltip = "Population: %d/%d" % [0,0]
	func init(vx, vy):
		x = vx
		y = vy
		if Global.Level.content_has_any(x,y,["House","Trees","Road","River"]) ==false:
			Global.content(Vector2(x,y)).append({"House":self})
			LevelState.add_cell([[x,y,"Items",0]])
			self._pop = [2,10,1]
			GameState.pop[0]+=_pop[0]
			GameState.pop[1]+=_pop[1]
			GameState.pop[2]+=_pop[2]
			
			var _p = Global.Helpers.get_range(x,y,4)
			var wood = 0
			var __tex = preload("res://UI/map_icons/res.png")
			tooltip =\
			"""Population: %d/%d
That house have access to %d wood.""" % [_pop[0],_pop[1],wood]
			
			Signals.connect("next_turn",self,"next_turn")
			Signals.connect("pre_next_turn",self,"pre_next_turn")
			_done = true
	
	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
	
	func pre_next_turn():
		
		var _p = Global.Helpers.get_range(x,y,4)
		var _min_used = -1
		var _tile = -1
		for j in range(_p[0].size()):
			if _p[1][j] > _min_used and Global.Level.content_has(_p[0][j].x,_p[0][j].y,"Trees"):
				_tile = _p[0][j]
		if typeof(_tile) == TYPE_VECTOR2:
			if Global.Level.content_has(_tile.x,_tile.y,"Trees"):
				Global.Level.content_get(_tile.x,_tile.y,"Trees").wood -= 10
		return

	func next_turn():
		var _r = int(round(rand_range(0,1)))
		if int(_pop[0]) >= int(_pop[1]):
			_r = round(int(_r)-1)
		GameState.pop[0] = int(GameState.pop[0]) + int(_pop[2])
		_pop[0] = int(_pop[0]) + int(_pop[2])
		GameState.pop[2] = int(GameState.pop[2]) + int(_r)
		_pop[2] = int(_r)
		var _p = Global.Helpers.get_range(x,y,4)
		var wood = 0
		var __tex = preload("res://UI/map_icons/res.png")
		for i in _p[0]:
			if Global.Level.content_has(i.x,i.y,"Trees"):
				wood += Global.Level.content_get(i.x,i.y,"Trees").wood
		tooltip =\
		"""Population: %d/%d
That house have access to %d wood.""" % [_pop[0],_pop[1],wood]
		for i in range(_p[0].size()):
			if Global.Level.content_has(_p[0][i].x,_p[0][i].y,"Trees"):
				wood += Global.Level.content_get(_p[0][i].x,_p[0][i].y,"Trees").wood
	#				Global.Helpers.light_static_helper_v2(__tex,Vector2(2,2),i*64)
		return
