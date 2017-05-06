extends Node

onready var _content = get_parent()._content
var x
var y

func init(xy):
	x=xy[0]
	y=xy[1]
func _ready():
	if randf() > 0.95 and\
		!_content[x][y].has("River") and\
		!_content[x][y].has("Road") and\
		_content.size()>x and\
		_content[x].size()>y:
			LevelState.add_cell([[x,y,"Trees",0]])
			_content[x][y].append("Trees")
			for i in [[x+1,y],[x-1,y],[x,y+1],[x,y-1]]:
				if randf() > 0.7 and\
				!_content[i[0]][i[1]].has("River") and\
				!_content[i[0]][i[1]].has("Road") and\
				_content.size()>i[0] and\
				_content[x].size()>i[1]:
					LevelState.add_cell([[i[0],i[1],"Trees",0]])
					_content[i[0]][i[1]].append("Trees")
			for i in [[x+2,y],[x-2,y],[x,y+2],[x,y-2]]:
				if randf() > 0.6 and\
				!_content[i[0]][i[1]].has("River") and\
				!_content[i[0]][i[1]].has("Road") and\
				_content.size()>i[0] and\
				_content[x].size()>i[1]:
					LevelState.add_cell([[i[0],i[1],"Trees",0]])
					_content[i[0]][i[1]].append("Trees")
			for i in [[x+1,y+1],[x-1,y-1],[x+1,y-1],[x-1,y+1]]:
				if randf() > 0.5 and\
				_content.size()>i[0] and\
				_content[x].size()>i[1] and\
				!_content[i[0]][i[1]].has("Road") and\
				!_content[i[0]][i[1]].has("River"):
					LevelState.add_cell([[i[0],i[1],"Trees",0]])
					_content[i[0]][i[1]].append("Trees")
