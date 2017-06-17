extends Node
class Road:
	var _done = false
	func init(vx, vy):
		var x = vx
		var y = vy
		if Global.Level.content_has_any(x,y,["Road","Trees","House","River"]) == false:
			!Global.content(Vector2(x,y)).append({"Road":self})
			update_road(x,y)
			var _s = [false,false,false,false]
			if x > 0:
				if Global.Level.content_has(x-1,y,"Road"):
					_s[0] = true
			if y > 0:
				if Global.Level.content_has(x,y-1,"Road"):
					_s[1] = true
			if x+1 < Global.Level._content.size():
				if Global.Level.content_has(x+1,y,"Road"):
					_s[2] = true
			if x < Global.Level._content.size() and y+1 < Global.Level._content[x].size():
				if Global.Level.content_has(x,y+1,"Road"):
					_s[3] = true
			if _s[0]:
				update_road(x-1,y)
			if _s[1]:
				update_road(x,y-1)
			if _s[2]:
				update_road(x+1,y)
			if _s[3]:
				update_road(x,y+1)
			_done = true

	func _ready():
		if _done:
			return(true)
		else:
			return(false)
	
	func update_road(x,y):
		var _s = [false,false,false,false]
		if x > 0:
			if Global.Level.content_has(x-1,y,"Road"):
				_s[0] = true
		if y > 0:
			if Global.Level.content_has(x,y-1,"Road"):
				_s[1] = true
		if x+1 < Global.Level._content.size():
			if Global.Level.content_has(x+1,y,"Road"):
				_s[2] = true
		if x < Global.Level._content.size() and y+1 < Global.Level._content[x].size():
			if Global.Level.content_has(x,y+1,"Road"):
				_s[3] = true
		LevelState.add_cell([[x,y,"Roads",6]])
		if _s[0] or _s[2]:
			LevelState.add_cell([[x,y,"Roads",0]])
		if _s[1] or _s[3]:
			LevelState.add_cell([[x,y,"Roads",1]])

		if (_s[0] and _s[1]):
			LevelState.add_cell([[x,y,"Roads",7]])
		if (_s[2] and _s[1]):
			LevelState.add_cell([[x,y,"Roads",12]])
		if (_s[0] and _s[3]):
			LevelState.add_cell([[x,y,"Roads",11]])
		if (_s[2] and _s[3]):
			LevelState.add_cell([[x,y,"Roads",9]])
	
		if _s[0] and _s[1] and _s[3] :
			LevelState.add_cell([[x,y,"Roads",2]])
		if _s[2] and _s[1] and _s[3]:
			LevelState.add_cell([[x,y,"Roads",3]])
		if _s[2] and _s[0] and _s[3]:
			LevelState.add_cell([[x,y,"Roads",4]])
		if _s[1] and _s[0] and _s[2]:
			LevelState.add_cell([[x,y,"Roads",5]])
		if _s[0] and _s[1] and _s[2] and _s[3]:
			LevelState.add_cell([[x,y,"Roads",6]])