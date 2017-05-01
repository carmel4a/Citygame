extends Node2D

var map_size = Vector2(100,100)
var _content = []
func _ready():
	
	for x in range(map_size.x):
		_content.append([])
		for y in range(map_size.y):
			_content[x].append([])
			_content[x][y].append([])
			grass(x,y)
			tree(x,y)
	GlobalMethods.build_a_house(floor(map_size.x/2),floor(map_size.y/2+1))
	GlobalMethods.build_a_house(floor(map_size.x/2),floor(map_size.y/2-1))
	GlobalMethods.add_cell([[floor(map_size.x/2),floor(map_size.y/2),"roads",6]])
	GlobalMethods.adding_to_map("Water",0)
func _add(c):
	
	for i in c:
		get_node(i[2]).set_cell(i[0],i[1],i[3])
		
func grass(x,y):
	
	var _r = randf()
	if _r > 0.75:
		GlobalMethods.add_cell([[x,y,"TileMap",0]])
	elif _r > 0.5:
		GlobalMethods.add_cell([[x,y,"TileMap",1]])
	elif _r > 0.05:
		GlobalMethods.add_cell([[x,y,"TileMap",2]])
	else:
		GlobalMethods.add_cell([[x,y,"TileMap",3]])

func tree(x,y):
	
	if randf() > 0.95:
		GlobalMethods.add_cell([[x,y,"Trees",0]])
		if randf() > 0.7:
			GlobalMethods.add_cell([[x+1,y,"Trees",0]])
		if randf() > 0.7:
			GlobalMethods.add_cell([[x-1,y,"Trees",0]])
		if randf() > 0.7:
			GlobalMethods.add_cell([[x,y+1,"Trees",0]])
		if randf() > 0.7:
			GlobalMethods.add_cell([[x,y-1,"Trees",0]])
		if randf() > 0.6:
			GlobalMethods.add_cell([[x+2,y,"Trees",0]])
		if randf() > 0.6:
			GlobalMethods.add_cell([[x-2,y,"Trees",0]])
		if randf() > 0.6:
			GlobalMethods.add_cell([[x,y+2,"Trees",0]])
		if randf() > 0.6:
			GlobalMethods.add_cell([[x,y-2,"Trees",0]])
		if randf() > 0.5:
			GlobalMethods.add_cell([[x+1,y+1,"Trees",0]])
		if randf() > 0.5:
			GlobalMethods.add_cell([[x+1,y-1,"Trees",0]])
		if randf() > 0.5:
			GlobalMethods.add_cell([[x-1,y+1,"Trees",0]])
		if randf() > 0.5:
			GlobalMethods.add_cell([[x-1,y-1,"Trees",0]])
