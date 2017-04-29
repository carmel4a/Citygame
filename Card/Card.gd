tool
extends PanelContainer

var dragging = false
var _prev_pos = Vector2(0,0)
var _clicked_pt 
var _content = {\
	"sys_name":"",
	"title":"",
	"image":"",
	"text":"",
	"options":{\
		"option1":{\
			"text":"",
			"sys_name":"",
			"tooltip":""
			},
		}
	}

onready var panel_size = get_node("Card-Perks/Top-Bottons/Top").get_size()

func _ready():
	
#	save_gd() # Only for debug/editing
	load_gd(_content["sys_name"])
	for i in _content["options"]:
		var _b = get_node("Card-Perks/Top-Bottons/VButtonArray/ButtonsGroup/Button").duplicate()
		_b.set_text(_content["options"][i]["text"])
		_b.set_tooltip(_content["options"][i]["tooltip"])
		_b.show()
		get_node("Card-Perks/Top-Bottons/VButtonArray/ButtonsGroup").add_child(_b)
		get_node("Card-Perks/Top-Bottons/Top/Name").set_text(_content["title"])
		get_node("Card-Perks/Top-Bottons/Text").set_text(_content["text"])
	
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
	
	_content.clear()
	var file = File.new()
	file.open("res://Card/Cards/"+name+"/" +name+".json",1)
	_content.parse_json(file.get_as_text())
	file.close()
	_update()

func _update():
	
	set_size(Vector2(0,0))

func _on_Option_button_selected( button_idx ):
	
	for i in get_node("Card-Perks").get_children(): 
		if i.get_name()=="Perks":
			get_node("Card-Perks/Perks").free()
	var _p = preload("res://Card/Perks.tscn").instance()
	_p.set_name("Perks")
	_p.init(_content["options"].keys()[button_idx.get_position_in_parent()-1],_content["sys_name"])
	get_node("Card-Perks").add_child(_p,true)

func _input_event(event):
	
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == 1:
		if event.pressed:
			if Rect2(Vector2(0,0),panel_size).has_point(event.pos) and dragging == false:
				accept_event()
				raise()
				dragging = true
				_clicked_pt = get_local_mouse_pos()
		else:
			dragging = false
