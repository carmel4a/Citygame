extends Node

onready var _content = get_parent()._content
var x
var y

func init(xy):
	
	x=xy[0]
	y=xy[1]

func _ready():
	
	if randf() > 0.95 and\
		Global.Level.content_has_any(x,y,["River","Road","House"]) == false and\
		x>=0 and\
		y>=0 and\
		_content.size()>=x and\
		_content[x].size()>=y:
			Economy.add_entitie("Trees",[x,y])
			for i in [[x+1,y],[x-1,y],[x,y+1],[x,y-1]]:
				if i[0] >= 0 and \
				i[1] >= 0 and \
				_content.size()>i[0] and\
				_content[x].size()>i[1]:
					if randf() > 0.7 and\
					Global.Level.content_has_any(i[0],i[1],["River","House","Road"]) == false:
						Economy.add_entitie("Trees",[i[0],i[1]])
			for i in [[x+2,y],[x-2,y],[x,y+2],[x,y-2]]:
				if i[0] >= 0 and \
				i[1] >= 0 and \
				_content.size()>i[0] and\
				_content[x].size()>i[1]:
					if randf() > 0.6 and\
					Global.Level.content_has_any(i[0],i[1],["River","House","Road"]) == false:
						Economy.add_entitie("Trees",[i[0],i[1]])
			for i in [[x+1,y+1],[x-1,y-1],[x+1,y-1],[x-1,y+1]]:
				if i[0] >= 0 and \
				i[1] >= 0 and \
				_content.size()>i[0] and\
				_content[x].size()>i[1]:
					if randf() > 0.5 and\
					Global.Level.content_has_any(i[0],i[1],["River","House","Road"]) == false:
						Economy.add_entitie("Trees",[i[0],i[1]])
