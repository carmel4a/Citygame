extends Node2D

var map_size = Vector2(100,100)
# pixels * scale
# Do not get scale from TileMaps, because various tilemaps
# have various scales.
var tile_size = 32*2

var _content = []
var _as = AStar.new()

func _ready():
	
	# make a _content 2D array
	for x in range(map_size.x):
		_content.append([])
		for y in range(map_size.y):
			_content[x].append([])
			_content[x][y].append([])
			# That +1 must occur, because of that,
			# first free a* ID starts on 1.
			var _p = Math._2D_1D(Vector2(x,y),map_size.x)
			_as.add_point(_p,Vector3(x,y,0))
			if x != 0:
				_as.connect_points(_p,_p-1)
			if y != 0:
				_as.connect_points(_p,_p-map_size.x)
	# GenMod beafore full map iteration
	# after 'in' pass a array of sorted scripts
	# in 'Level/GenMod' and args[]
	var _h = Node.new()
	_h.set_name("_h")
	add_child(_h)
	_h = get_node("_h")
	for i in [\
	["river",null],\
	["main_road",["v"]],\
	["main_road",["h"]]
	]:
		var _s = load("res://Level/GenMod/"+i[0]+".gd")
		_h.set_script(_s)
		_h.init(i[1])
		_h._ready()
	# Full map iteration
	for x in range(map_size.x):
		for y in range(map_size.x):
			# GenMod for each cell
			# after 'in' pass a array of sorted scripts in Level/GenMod
			for i in [\
			["tree",[x,y]]\
			]:
				var _s = load("res://Level/GenMod/"+i[0]+".gd")
				_h.set_script(_s)
				_h.init(i[1])
				_h._ready()
			grass(x,y)

	# here will be more complex GenMods wich depends
	# on each other and/or need multiple iterations,
	# working on threads, etc.
	
# A framework func wich allow to direct add a cells to multiple TileMaps,
# with various types of cells, layers etc. Data are passed in ar=[tile1[],tile2[]]
# where tile* is an array [x,y, layer (Level's Tilemaps as str()), type]
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
