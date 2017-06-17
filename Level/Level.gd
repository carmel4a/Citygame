# Main level node. Load, save, serialize, buffer, generate, ect.
extends Node2D

export (Vector2) var map_size = Vector2(100,100)

# pixels * scale
# Do not get scale from TileMaps, because various tilemaps
# have various scales.
var tile_size = 32*2

# 2D array. As vars has array with dicts {name:obj}
# e.g _content[5][25][ID-in-list].keys()[0] is way to access object name.
# We must know witch object we want on list.
# To get obj. use content_get()
# To check if there is a obj. use content_has()
# To check if there is any obj. use content_has_any()
var _content = []

# AStar, created, but not used anywhere yet
var _as = AStar.new()

func _ready():
	
	# Make a _content 2D array
	for x in range(map_size.x):
		_content.append([])
		for y in range(map_size.y):
			_content[x].append([])
			# That +1 must occur, because of
			# the first free a* ID starts on 1.
			var _p = Math._2D_1D(Vector2(x,y),map_size.x)
			_as.add_point(_p,Vector3(x,y,0))
			if x != 0:
				_as.connect_points(_p,_p-1)
			if y != 0:
				_as.connect_points(_p,_p-map_size.x)
	# A heper node to load GenMos.
	var _GenMod = Node.new()
	_GenMod.set_name("_GenMod")
	add_child(_GenMod)
	# GenMod beafore full map iteration
	# as arg pass an array of arrays:
	# [name of script, args[]]
	_gen_mods([\
	["river",null],\
	["main_road",["v"]],\
	["main_road",["h"]]
	])
	# Full map iteration
	for x in range(map_size.x):
		for y in range(map_size.x):
			# GenMod for each cell
			# as arg pass an array of arrays:
			# [name of script, args[]]
			_gen_mods([\
			["tree",[x,y]]\
			])
			Economy.add_entitie("Grass",[x,y])
	# here will be more complex GenMods wich depends
	# on each other and/or need multiple iterations,
	# working on threads, etc.
	_gen_mods([])
	_GenMod.queue_free()

# A framework func wich allow to direct add cells to multiple TileMaps,
# with various types of cells, etc. Data are passed in ar=[tile1[],tile2[]]
# where tile* is an array [x,y, layer (Level's Tilemap's name as str()), type]
func _add(c):
	
	for i in c:
		get_node(i[2]).set_cell(i[0],i[1],i[3])

# Function to execute a generator module. Note that a class of GenMod doesn't
# use native _init, class isn't even instanced. 
func _gen_mods(arr):
	
	var _s
	for i in arr:
		_s = load("res://Level/GenMod/"+i[0]+".gd")
		get_node("_GenMod").set_script(_s)
		get_node("_GenMod").init(i[1])
		get_node("_GenMod")._ready()

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

func content_get(x,y,s):
	for i in _content[x][y]:
		if i.keys()[0] == s:
			return(i[i.keys()[0]])
