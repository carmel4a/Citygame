tool
extends PanelContainer

var _prev_pos = Vector2(0,0)
var _clicked_pt 
var dragging = false
var _as = AStar.new()
var _content = {\
	"sys_name":"_temp",
	"title":"",
	"image":"",
	"text":"",
	"options":{\
		"option1":{\
			"text":"Droga",
			"sys_name":"Droga"
			},
		"option2":{\
			"text":"Dom",
			"sys_name":"Dom"
			}
		}
	}

func _ready():
	print("Here ", self.get_name())
	load_gd("_temp")
	for i in _content["options"]:
		var _b = get_node("VBoxContainer/VButtonArray/ButtonsGroup/Button").duplicate()
		_b.set_text(_content["options"][i]["text"])
		_b.show()
		get_node("VBoxContainer/VButtonArray/ButtonsGroup").add_child(_b)
	set_process_input(true)
	set_process(true)
	
func _process(delta):

	if dragging == true:
		set_pos(get_global_mouse_pos()-_clicked_pt)
		
func _init(what = null):
	
	if what != null:
		_content["sys_name"] = what
	else:
		_content["sys_name"] = "_temp"

func _on_close():
	
	hide()
	queue_free()

func save_gd():
	
	var file = File.new()
	var _dir = Directory.new()
	if _content["sys_name"] != "":
		_dir.make_dir("res://Card/Cards/"+_content["sys_name"])
		file.open("res://Card/Cards/"+_content["sys_name"] +"/" +_content["sys_name"]+".json",2)
	else:
		_dir.make_dir("res://Cards/_temp/")
		file.open("res://Card/Cards/_temp/_temp.json",2)
	file.store_string(_content.to_json())
	file.close()
	
func load_gd(name):
	
	var file = File.new()
	file.open("res://Card/Cards/"+_content["sys_name"] +"/" +_content["sys_name"]+".json",1)
	_content.clear()
	_content.parse_json(file.get_as_text())
	file.close()
	_update()

func _update():
	
	set_size(Vector2(0,0))

func _on_Option_button_selected( button_idx ):
	
	print(button_idx)
	
func _input_event(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == 1:
		if event.pressed:
			if Rect2(Vector2(0,0),Vector2(129,25)).has_point(event.pos) and dragging == false:
				accept_event()
				raise()
				dragging = true
				_clicked_pt = get_local_mouse_pos()
		else:
			dragging = false