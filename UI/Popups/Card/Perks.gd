extends GridContainer

var what
var where
var _yielded
var waiting
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
		if i.get_name() == "option":
			get_node("option").queue_free()
	_h.set_script(load("res://UI/Popups/Card/Cards/"+where+"/"+what+".gd"))
	_h.set_name("option")
	add_child(_h,true)
	
	show()

func set_perk(id):
	var _c = preload("res://UI/Popups/Card/PerkButton.tscn").instance()
	get_children()[id].queue_free()
	_c.init(id)
	add_child(_c)
	move_child(get_children()[get_child_count()-1],id-1)
func pressed(id):
	Signals.connect("emited",self,"recived")
	_yielded = get_node("option").call(str("perk_"+str(id)))
func _unyield():
	if _yielded != null:
		_yielded = _yielded.resume()
	

func wait_for(s):
	
	waiting = s
func recived(s):
	if s == waiting:
		_unyield()

func end_perk(id):
	waiting = null
	_yielded = null
	if Signals.is_connected("emited",self,"recived"):
		Signals.disconnect("emited",self,"recived")
	get_children()[id-1].set_disabled(true)
