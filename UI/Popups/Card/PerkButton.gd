extends Button
var ID

var tooltip = "a button"

func init(id,vtooltip):
	
	ID = id
	tooltip = vtooltip

func _ready():
	
	connect("pressed",get_parent(),"pressed",[ID])
