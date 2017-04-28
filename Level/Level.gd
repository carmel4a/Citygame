extends Node2D

var map_size = Vector2(100,100)

func _ready():
	
	for x in range(map_size.x):
		for y in range(map_size.y):
			GlobalMethods.add_cell([[x,y,"TileMap",0]])
	GlobalMethods.add_cell([[floor(map_size.x/2),floor(map_size.y/2),"roads",6],\
		[floor(map_size.x/2),floor(map_size.y/2+1),"items",0],
		[floor(map_size.x/2),floor(map_size.y/2-1),"items",0],
	])
func _add(c):
	for i in c:
		get_node(i[2]).set_cell(i[0],i[1],i[3])