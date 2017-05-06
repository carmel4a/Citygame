extends Node

static func _1D_2D():
	pass

static func _2D_1D(v,w):
	
	return(v.y*w+v.x)

static func _get_middle(va,vb):
	
	return((va+vb)/2)

static func _get_v_fromv(va,vb):
	
	return((vb-va)/2)
