tool
extends PanelContainer

var _dragging = false

onready var panel_size = get_node("Card-Perks/Top-Bottons/Top").get_size()
onready var _prev_pos = get_pos()

var _OptionButton = preload("res://UI/Popups/Card/OptionButton.tscn")
var _cardFolder = "res://UI/Popups/Card/"
onready var _ButtonGroup = get_node("Card-Perks/Top-Bottons/VButtonArray/ButtonsGroup")
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
			"tooltip":"" #bbcCode
			},
		}
	}

func _ready():
	
#	save_gd() # Only for debug/editing
	load_gd(_content["sys_name"])
	for i in _content["options"]:
		var _b = _OptionButton.instance()
		_b.set_text(_content["options"][i]["text"])
		Signals.connect_to_tooltip(_b,_content["options"][i]["tooltip"])
		_b.show()
		_ButtonGroup.add_child(_b)
		get_node("Card-Perks/Top-Bottons/Top/Name").set_text(_content["title"])
		get_node("Card-Perks/Top-Bottons/Text").set_text(_content["text"])
	set_size(Vector2(200,get_size().y))
	panel_size = get_node("Card-Perks/Top-Bottons/Top").get_size()
	set_process(true)

func _process(delta):

	if _dragging:
		# yayayayayayayaya....
		set_pos(Global.UI.get_local_mouse_pos()-_clicked_pt-get_parent().get_pos())
		
func init(what = null):
	
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
		_dir.make_dir(_cardFolder + "Cards/"+_content["sys_name"])
		file.open(_cardFolder + "Cards/"+_content["sys_name"] +"/" +_content["sys_name"]+".json",2)
	else:
		_dir.make_dir(_cardFolder + "/_temp/")
		file.open(_cardFolder + "_temp/_temp.json",2)
	file.store_string(_content.to_json())
	file.close()

func load_gd(name):
	
	_content.clear()
	var file = File.new()
	file.open(_cardFolder + "Cards/"+name+"/" +name+".json",1)
	_content.parse_json(file.get_as_text())
	file.close()
	_update()

func _update():
	
	set_size(Vector2(0,0))

func _on_Option_button_selected( button_idx ):
	
	for i in get_node("Card-Perks").get_children(): 
		if i.get_name()=="Perks":
			get_node("Card-Perks/Perks").free()
	var _p = preload("res://UI/Popups/Card/Perks.tscn").instance()
	_p.set_name("Perks")
	_p.init(_content["options"].keys()[button_idx.get_position_in_parent()-1],_content["sys_name"])
	get_node("Card-Perks").add_child(_p,true)

func _input_event(event):
	
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == 1:
		if event.pressed:
			if Rect2(Vector2(0,0),panel_size).has_point(event.pos) and _dragging == false:
				accept_event()
				raise()
				_dragging = true
				_clicked_pt = panel_size - event.pos
		if !event.pressed:
			_dragging = false
