extends Node
onready var map_size = get_parent().map_size
onready var _content = get_parent()._content
var d
func init(ar):
	
	d = ar[0]

func _ready():
	
	var _sl = Vector2()
	var _el = Vector2()
	if d=="v":
		_sl = Vector2(rand_range(0,map_size.x),0).floor()
		_el = Vector2(rand_range(0,map_size.x),map_size.y).floor()
	if d=="h":
		_sl = Vector2(0,rand_range(0,map_size.y)).floor()
		_el = Vector2(map_size.x,rand_range(0,map_size.y)).floor()
	var _ar = [_sl,_el]
	var _bp = Curve2D.new()
	_bp.set_bake_interval(0.99)
	_bp.add_point(_ar[0])
	_bp.add_point(_ar[1])

	
	var ok = false
	var _point
	while !ok:
		var _d = round(rand_range(-10,10))
		_point = Math._get_middle(_bp.get_point_pos(0),_bp.get_point_pos(1))+(Math._get_v_fromv(_bp.get_point_pos(0),_bp.get_point_pos(1)).normalized().tangent())*_d
		if _point.x >= 0 and _point.y >= 0 and _point.x < map_size.x and _point.y < map_size.x:
			ok = true
	ok = false
	_bp.add_point(_point,\
		Vector2(0,0),\
		Vector2(0,0),\
		1)
	
	for i in range(3):
		for j in range(1,_bp.get_point_count()-1,2):
			var ok = false
			var _point
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
	for i in range(_bp.get_baked_points().size()-1):
		if _content.size()>_bp.get_baked_points()[i].x and\
		_content[_bp.get_baked_points()[i].x].size()>_bp.get_baked_points()[i].y:
			Economy.add_entitie("Road",[_bp.get_baked_points()[i].x,_bp.get_baked_points()[i].y])
			if _bp.get_baked_points()[i].x > 0 and _bp.get_baked_points()[i].y > 0:
				if (floor(_bp.get_baked_points()[i-1].x) != floor(_bp.get_baked_points()[i].x)) and (floor(_bp.get_baked_points()[i-1].y) != floor(_bp.get_baked_points()[i].y)):
					if _bp.get_baked_points()[i].x-_bp.get_baked_points()[i-1].x>=0:
						Economy.add_entitie("Road",[_bp.get_baked_points()[i].x-1,_bp.get_baked_points()[i].y])
						
					else:
						Economy.add_entitie("Road",[_bp.get_baked_points()[i].x+1,_bp.get_baked_points()[i].y])
						
