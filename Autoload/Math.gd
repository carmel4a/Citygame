extends Node

static func _1D_2D():
	pass

static func _2D_1D(v,w):
	
	return(v.y*w+v.x)

static func _get_middle(va,vb):
	
	return((va+vb)/2)

static func _get_v_fromv(va,vb):
	
	return((vb-va)/2)

static func _is_on_map(p,ms,s):
	if p.x >= 0 and p.y >= 0 and p.x < ms.x*s and p.y < ms.y*s:
		return(true)
	return(false)
