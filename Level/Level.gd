extends Node2D

var map_size = Vector2(100,100)
# pixels * scale
# Do not get scale from TileMaps, because various tilemaps
# have various scales.
var tile_size = 32*2

var _content = []
var _as = AStar.new()
onready var _h = Node.new()
func _ready():
	
	# make a _content 2D array
	for x in range(map_size.x):
		_content.append([])
		for y in range(map_size.y):
			_content[x].append([])
			
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
	
	_h.set_name("_h")
	add_child(_h)
	_h = get_node("_h")
	_gen_mods([\
	["river",null],\
	["main_road",["v"]],\
	["main_road",["h"]]
	])
	# Full map iteration
	for x in range(map_size.x):
		for y in range(map_size.x):
			# GenMod for each cell
			# after 'in' pass a array of sorted scripts in Level/GenMod
			_gen_mods([\
			["tree",[x,y]]\
			])
			Economy.add_entitie("Grass",[x,y])
	# here will be more complex GenMods wich depends
	# on each other and/or need multiple iterations,
	# working on threads, etc.
	_gen_mods([])
# A framework func wich allow to direct add a cells to multiple TileMaps,
# with various types of cells, layers etc. Data are passed in ar=[tile1[],tile2[]]
# where tile* is an array [x,y, layer (Level's Tilemap's name as str()), type]
func _add(c):
	
	for i in c:
		get_node(i[2]).set_cell(i[0],i[1],i[3])

func _gen_mods(arr):
	for i in arr:
		var _s = load("res://Level/GenMod/"+i[0]+".gd")
		_h.set_script(_s)
		_h.init(i[1])
		_h._ready()


func content_has(x,y,s):
	
	for i in _content[x][y]:
		if i.keys()[0] == s:
			return(true)
	return(false)

# Get position of tile, and array of strings to check.
# Return strings wich are in tile, or false if there's any of them.
func content_has_any(x,y,s):
	var _r = []
	for i in s:
		for j in _content[x][y]:
			if j.keys()[0] == i:
				_r.append(s)
	if _r.size() == 0:
		return(false)
	return(_r)