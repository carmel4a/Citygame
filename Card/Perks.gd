extends GridContainer

var what
var where

func init(wt,wr):
	
	what = wt
	where = wr

func _ready():
	for i in range(24):
		var _c = Control.new()
		_c.set_custom_minimum_size(Vector2(20,20))
		add_child(_c)
	var _h = Node.new()
	for i in get_children():
		if i.get_name() == "helper":
			get_node("helper").queue_free()
	_h.set_script(load("res://Card/Cards/"+where+"/"+what+".gd"))
	_h.set_name("helper")
	add_child(_h,true)
	
	show()
	
	
func set_perk(id):
	var _c = Button.new()
	_c.set_custom_minimum_size(Vector2(20,20))
	get_children()[id].queue_free()
	add_child(_c)
	move_child(get_children()[get_child_count()-1],id-1)