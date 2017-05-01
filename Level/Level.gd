extends Node2D

var map_size = Vector2(100,100)
var tile_size = 32*2
var _content = []
var _as = AStar.new()

func _ready():
	
	for x in range(map_size.x):
		_content.append([])
		for y in range(map_size.y):
			_content[x].append([])
			_content[x][y].append([])
			
			var _p = y*map_size.x+x+1
			_as.add_point(_p,Vector3(x,y,0))
			if x != 0:
				_as.connect_points(_p,_p-1)
			if y != 0:
				_as.connect_points(_p,\
					_p-map_size.x)
			
			grass(x,y)
			tree(x,y)

	Global.build_a_house(floor(map_size.x/2),floor(map_size.y/2+1))
	Global.build_a_house(floor(map_size.x/2),floor(map_size.y/2-1))
	Global.add_cell([[floor(map_size.x/2),floor(map_size.y/2),"Roads",6]])
	Global.adding_to_map("Water",0)

func _add(c):
	
	for i in c:
		get_node(i[2]).set_cell(i[0],i[1],i[3])

func grass(x,y):
	
	var _r = randf()
	if _r > 0.75:
		LevelState.add_cell([[x,y,"Grass",0]])
	elif _r > 0.5:
		LevelState.add_cell([[x,y,"Grass",1]])
	elif _r > 0.05:
		LevelState.add_cell([[x,y,"Grass",2]])
	else:
		LevelState.add_cell([[x,y,"Grass",3]])

func tree(x,y):
	#omg
	if randf() > 0.95:
		LevelState.add_cell([[x,y,"Trees",0]])
		if randf() > 0.7:
			LevelState.add_cell([[x+1,y,"Trees",0]])
		if randf() > 0.7:
			LevelState.add_cell([[x-1,y,"Trees",0]])
		if randf() > 0.7:
			LevelState.add_cell([[x,y+1,"Trees",0]])
		if randf() > 0.7:
			LevelState.add_cell([[x,y-1,"Trees",0]])
		if randf() > 0.6:
			LevelState.add_cell([[x+2,y,"Trees",0]])
		if randf() > 0.6:
			LevelState.add_cell([[x-2,y,"Trees",0]])
		if randf() > 0.6:
			LevelState.add_cell([[x,y+2,"Trees",0]])
		if randf() > 0.6:
			LevelState.add_cell([[x,y-2,"Trees",0]])
		if randf() > 0.5:
			LevelState.add_cell([[x+1,y+1,"Trees",0]])
		if randf() > 0.5:
			LevelState.add_cell([[x+1,y-1,"Trees",0]])
		if randf() > 0.5:
			LevelState.add_cell([[x-1,y+1,"Trees",0]])
		if randf() > 0.5:
			LevelState.add_cell([[x-1,y-1,"Trees",0]])
