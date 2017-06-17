extends Node

onready var _content = get_parent()._content

var x
var y

func init(xy):
	
	x=xy[0]
	y=xy[1]

func _ready():
	
	var _t = ["young","medium","old"]
	var rtype = randi()%_t.size()
	var type = _t[rtype]
	if randf() > 0.85 and\
	Global.Level.content_has_any(x,y,["River","Road","House","Trees"]) == false and\
	Math._is_on_map(Vector2(x,y),get_parent().map_size,1):
		Economy.add_entitie("Trees",[x,y,type])
		for i in [[x+1,y],[x-1,y],[x,y+1],[x,y-1]]:
			if Math._is_on_map(Vector2(i[0],i[1]),get_parent().map_size,1) and\
			randf() > 0.7 and\
			Global.Level.content_has_any(i[0],i[1],\
			["River","House","Road","Trees"]) == false:
				Economy.add_entitie("Trees",[i[0],i[1],type])
		for i in [[x+2,y],[x-2,y],[x,y+2],[x,y-2]]:
			if Math._is_on_map(Vector2(i[0],i[1]),get_parent().map_size,1) and\
			randf() > 0.6 and\
			Global.Level.content_has_any(i[0],i[1],\
			["River","House","Road","Trees"]) == false:
				Economy.add_entitie("Trees",[i[0],i[1],type])
		for i in [[x+1,y+1],[x-1,y-1],[x+1,y-1],[x-1,y+1]]:
			if Math._is_on_map(Vector2(i[0],i[1]),get_parent().map_size,1) and\
			randf() > 0.5 and\
			Global.Level.content_has_any(i[0],i[1],\
			["River","House","Road","Trees"]) == false:
				Economy.add_entitie("Trees",[i[0],i[1],type])
