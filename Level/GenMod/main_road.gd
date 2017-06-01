extends Node

# Point is shifted by that after added to create polyline.
var point_shift = 10
# How much segment'll be fragmented
var no_segment_iteration = 3

onready var map_size = get_parent().map_size
onready var _content = get_parent()._content
# Direction: 'v'ertical or 'h'orizontal
var d

func init(ar):
	
	d = ar[0]

func _ready():
	
	# start location; end location
	var _sl = Vector2()
	var _el = Vector2()
	if d == "v":
		_sl = Vector2(rand_range(0,map_size.x),0).floor()
		_el = Vector2(rand_range(0,map_size.x),map_size.y).floor()
	if d == "h":
		_sl = Vector2(0,rand_range(0,map_size.y)).floor()
		_el = Vector2(map_size.x,rand_range(0,map_size.y)).floor()
	# Buffer path
	var _bp = Curve2D.new()
	_bp.set_bake_interval(0.99)
	_bp.add_point(_sl)
	_bp.add_point(_el)
	var _ok = false
	var _point
	while !_ok:
		var _d = round(rand_range(-point_shift,point_shift))
		_point = Math._get_middle(\
		_bp.get_point_pos(0),\
		_bp.get_point_pos(1))\
		+(Math._get_v_fromv(\
		_bp.get_point_pos(0),\
		_bp.get_point_pos(1)).normalized().tangent())*_d
		_ok = Math._is_on_map(_point, map_size,1)
	_ok = false
	_bp.add_point(_point,\
	Vector2(0,0),\
	Vector2(0,0),\
	1)
	for i in range(no_segment_iteration):
		for j in range(1,_bp.get_point_count()-1,2):
			var ok = false
			var _point
			while !ok:
				var _d = round(rand_range(-point_shift,point_shift))
				_point = Math._get_middle(\
				_bp.get_point_pos(j),\
				_bp.get_point_pos(j+1))\
				+(Math._get_v_fromv(_bp.get_point_pos(j),\
				_bp.get_point_pos(j+1)).normalized().tangent())*_d
				ok = Math._is_on_map(_point, map_size,1)
			ok = false
			_bp.add_point(_point,\
			Vector2(0,0),\
			Vector2(0,0),\
			j+1)
	for i in range(_bp.get_baked_points().size()-1):
		var _p = _bp.get_baked_points()[i]
		if Math._is_on_map(_p,map_size,1):
			Economy.add_entitie("Road",[_p.x,_p.y])
			if (floor(_bp.get_baked_points()[i-1].x) != floor(_p.x)) and \
			(floor(_bp.get_baked_points()[i-1].y) != floor(_p.y)):
				if _p.x-_bp.get_baked_points()[i-1].x>=0:
					Economy.add_entitie("Road",[_p.x-1,_p.y])
				else:
					Economy.add_entitie("Road",[_p.x+1,_p.y])
