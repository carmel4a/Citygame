extends Button
var ID
func init(id):
	ID = id

func _ready():
	connect("pressed",get_parent(),"pressed",[ID])
