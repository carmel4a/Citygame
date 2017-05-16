extends Node
onready var map_size = get_parent().map_size
onready var _content = get_parent()._content

func init(_):
	return

func _ready():
	
	var _s1 = randi()%4
	var _ar = [Vector2(),Vector2()]
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
			_ar[i] = Vector2(map_size.x,rand_range(0,map_size.y)).floor()
		if _s2 == 3:
			_ar[i] = Vector2(rand_range(0,map_size.x),map_size.y).floor()
	var _bp = Curve2D.new()
	var _p = Curve2D.new()
	_bp.set_bake_interval(0.99)
	_p.set_bake_interval(0.99)
	_bp.add_point(_ar[0])
	_bp.add_point(_ar[1])
	var ok = false
	var _point
	while !ok:
		var _d = round(rand_range(-50,50))
		_point = Math._get_middle(_bp.get_point_pos(0),_bp.get_point_pos(1))+(Math._get_v_fromv(_bp.get_point_pos(0),_bp.get_point_pos(1)).normalized().tangent())*_d
		if _point.x >= 0 and _point.y >= 0 and _point.x < map_size.x and _point.y < map_size.x:
			ok = true
	ok = false
	_bp.add_point(_point,\
		Vector2(0,0),\
		Vector2(0,0),\
		1)
	for i in range(4):
		for j in range(1,_bp.get_point_count()-1,2):
			while !ok:
				var _d = round(rand_range(-10,10))
				_point = Math._get_middle(_bp.get_point_pos(j),_bp.get_point_pos(j+1))+(Math._get_v_fromv(_bp.get_point_pos(j),_bp.get_point_pos(j+1)).normalized().tangent())*_d
				if _point.x >= 0 and _point.y >= 0 and _point.x < map_size.x and _point.y < map_size.x:
					ok = true
			ok = false
			_bp.add_point(_point,\
				Vector2(0,0),\
				Vector2(0,0),\
				j+1)
	for i in range(_bp.get_point_count()-1):
		_p.add_point(Math._get_middle(_bp.get_point_pos(i+1),_bp.get_point_pos(i)),\
		Vector2(0,0),\
		Math._get_middle(_bp.get_point_pos(i+1),_bp.get_point_pos(i))-_bp.get_point_pos(i))
	_p.add_point(_ar[0],Vector2(0,0),Vector2(0,0),0)
	_p.add_point(_ar[1])
#	for i in _bp.get_baked_points():
#		LevelState.add_cell([[i.x,i.y,"Water",0]])
	for i in _p.get_baked_points():
		if _content.size()>i.floor().x and\
		_content[i.floor().x].size()>i.floor().y:
			
			
			if (i.floor().x+1 < _content.size()):
				
				Economy.add_entitie("River",[i.floor().x+1,i.floor().y])
			if (i.floor().y+1 < _content[i.floor().x].size()):
				
				Economy.add_entitie("River",[i.floor().x,i.floor().y+1])
			Economy.add_entitie("River",[i.floor().x,i.floor().y])
