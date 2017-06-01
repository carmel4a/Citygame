extends Node

# Point is shifted by that after added to create polyline.
var point_shift = 10
# How much segment'll be fragmented
var no_segment_iteration = 4

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
		var _d = round(rand_range(-point_shift*5,point_shift*5))
		_point = Math._get_middle(\
		_bp.get_point_pos(0),\
		_bp.get_point_pos(1))\
		+(Math._get_v_fromv(_bp.get_point_pos(0),\
		_bp.get_point_pos(1)).normalized().tangent())*_d
		ok = Math._is_on_map(_point,map_size,1)
	ok = false
	_bp.add_point(_point,\
	Vector2(0,0),\
	Vector2(0,0),\
	1)
	for i in range(no_segment_iteration):
		for j in range(1,_bp.get_point_count()-1,2):
			while !ok:
				var _d = round(rand_range(-point_shift,point_shift))
				_point = Math._get_middle(\
				_bp.get_point_pos(j),\
				_bp.get_point_pos(j+1))\
				+(Math._get_v_fromv(_bp.get_point_pos(j),\
				_bp.get_point_pos(j+1)).normalized().tangent())*_d
				ok = Math._is_on_map(_point,map_size,1)
			ok = false
			_bp.add_point(_point,\
			Vector2(0,0),\
			Vector2(0,0),\
			j+1)
	for i in range(_bp.get_point_count()-1):
		_p.add_point(\
		Math._get_middle(_bp.get_point_pos(i+1),_bp.get_point_pos(i)),\
		Vector2(0,0),\
		Math._get_middle(\
		_bp.get_point_pos(i+1),\
		_bp.get_point_pos(i))-_bp.get_point_pos(i))
	_p.add_point(_ar[0],Vector2(0,0),Vector2(0,0),0)
	_p.add_point(_ar[1])
	for i in _p.get_baked_points():
		for j in [i.floor() + Vector2(-1,0), i.floor() + Vector2(0,-1),\
		i.floor() + Vector2(1,0), i.floor() + Vector2(0,1), i.floor()]:
			if Math._is_on_map(j,map_size,1):
				Economy.add_entitie("River",[j.x,j.y])
