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
	river()
	river()
	
	Global.build_a_house(floor(map_size.x/2),floor(map_size.y/2+1))
	Global.build_a_house(floor(map_size.x/2),floor(map_size.y/2-1))
	LevelState.add_cell([[floor(map_size.x/2),floor(map_size.y/2),"Roads",6]])
	LevelState.adding_to_map("Water",0)

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
func _get_middle(va,vb):
	return(Vector2((va.x+vb.x)/2,(va.y+vb.y)/2))
func _get_v_from(va,vb):
	return((vb-va)/2)
func river():
	var _s1 = randi()%4
	var _sl = Vector2()
	var _el = Vector2()
	var _ar = [_sl,_el]
	for i in range(2):
		var _s2 = randi()%4
		while _s1 == _s2:
			_s2 = randi()%4
		_s1 = _s2
		if _s2 == 0:
			_ar[i] = Vector2(0,rand_range(0,map_size.y)).floor()
		if _s2 == 1:
			_ar[i] = Vector2(rand_range(0,map_size.x),0).floor()
		if _s2 == 2:
			_ar[i] = Vector2(map_size.x-1,rand_range(0,map_size.y)).floor()
		if _s2 == 3:
			_ar[i] = Vector2(rand_range(0,map_size.x),map_size.y-1).floor()
	LevelState.add_cell([[_ar[0].x,_ar[0].y,"Water",0]])
	LevelState.add_cell([[_ar[1].x,_ar[1].y,"Water",0]])
	var _bp = Curve2D.new()
	var _p = Curve2D.new()
	
	_bp.set_bake_interval(0.8)
	_p.set_bake_interval(0.8)
	_bp.add_point(_ar[0])
	_bp.add_point(_ar[1])
	var _d = round(rand_range(-50,50))
	_bp.add_point(_get_middle(_bp.get_point_pos(0),_bp.get_point_pos(1))+(_get_v_from(_bp.get_point_pos(0),_bp.get_point_pos(1)).normalized().tangent())*_d,\
		Vector2(0,0),\
		Vector2(0,0),\
		1)
	for i in range(4):
		for j in range(1,_bp.get_point_count()-1,2):
			_d = round(rand_range(-10,10))
			_bp.add_point(_get_middle(_bp.get_point_pos(j),_bp.get_point_pos(j+1))+(_get_v_from(_bp.get_point_pos(j),_bp.get_point_pos(j+1)).normalized().tangent())*_d,\
		Vector2(0,0),\
		Vector2(0,0),\
		j+1)
	for i in range(_bp.get_point_count()-1):
		_p.add_point(_get_middle(_bp.get_point_pos(i+1),_bp.get_point_pos(i)),\
		Vector2(0,0),\
		_get_middle(_bp.get_point_pos(i+1),_bp.get_point_pos(i))-_bp.get_point_pos(i))
		
	_p.add_point(_ar[0],Vector2(0,0),Vector2(0,0),0)
	_p.add_point(_ar[1])
#	for i in _bp.get_baked_points():
#		LevelState.add_cell([[i.x,i.y,"Water",0]])
	for i in _p.get_baked_points():
		LevelState.add_cell([[i.x,i.y,"Water",0]])
#		LevelState.add_cell([[i.x-1,i.y,"Water",0]])
