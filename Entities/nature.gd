extends Node

class Grass:
	var _done = false
	var tooltip = "A Grassland"
	func init(vx, vy):
		
		var x = vx
		var y = vy
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
	func init(vx, vy):
		
		var x = vx
		var y = vy
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
	var x
	var y
	var true_age
	var age = -1
	var type
	var wood = -1
	var tooltip =\
"""Wood: %d
Age: %s"""
	
	# tile, years, max-wood # WHY Array is reversed?? 
	var types = {\
	"young":[0,[0,10],5],\
	"medium":[1,[11,25],10],\
	"old":[2,[26,26],20],\
	}
	# nope, you don't see that mix order dict workaround :<<
	var t_order = ["young","medium","old"]
	func init(vx, vy, vt = "medium", vage = null):
		
		x = vx
		y = vy
		type = vt
		if vage != null:
			vage = age
		else:
			age = round(rand_range(types[type][1][0],types[type][1][1]))
		if !Global.Level.content_has(x,y,"Trees"):
			Global.content(Vector2(x,y)).append({"Trees":self})
			LevelState.add_cell([[x,y,"Trees",types[type][0]]])
			Signals.connect("pre_next_turn",self,"pre_next_turn")
			Signals.connect("next_turn",self,"next_turn")
			_done = true
	
	func _ready():
		
		if _done:
			wood = types[type][2]
			tooltip =\
			"""Wood: %d
Age: %s""" % [wood,age]
			return(true)
		else:
			return(false)
	func pre_next_turn():
		
		var rand = randf()
		if rand >=0.995 and type == "old":
			_exit_tree()
		if rand >=0.8 and type == "medium":
			var dr = [Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)]
			var randii = randi() % 4
			if Math._is_on_map(Vector2(x+dr[randii].x,y+dr[randii].y),Global.Level.map_size,1) and\
			Global.Level.content_has_any(x+dr[randii].x,y+dr[randii].y,\
			["River","House","Road","Trees"]) == false:
				Economy.add_entitie("Trees",[x+dr[randii].x,y+dr[randii].y,"young",0])
	
	func next_turn():
		
		if wood <= 0:
			_exit_tree()
		age += 1
		if age > types[type][1][1] and type != "old":
			var act = t_order.find(type)
			type = t_order[act + 1]
			LevelState.add_cell([[x,y,"Trees",types[type][0]]])
			wood = types[type][2]
		tooltip =\
		"""Wood: %d
Age: %s""" % [wood,age]

	func _exit_tree():
		
		LevelState.add_cell([[x,y,"Trees",-1]])
#		Global.content(Vector2(x,y)).erase({"Trees":self})
		Global.content(Vector2(x,y)).remove(Global.Level.content_get_id(x,y,"Trees"))
		Signals.disconnect("next_turn",self,"next_turn")
