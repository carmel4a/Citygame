extends RichTextLabel
var _first = false

func _ready():
	update()

func update():
	if !_first:
		get_v_scroll().show()
		_first = true
	set_size(Vector2(get_size().x,get_size().y+1))
	if get_v_scroll().is_visible():
		call_deferred("update")
	else:
		get_v_scroll().hide()
		get_parent().set_size(get_size())
		