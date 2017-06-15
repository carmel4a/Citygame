extends Node

var _Turn = 0
# authority: cur, delta
var Auth  = [10,5]
# difference of authority per turn
var pop = [0,0,0] # cur, max, delta

var _state = ["idle"]
var klick = [false,Vector2(-1,-1)]
var _mp
var _lmp

var _script_helper = Node.new()

var States={\
	"idle":preload("res://GameStates/idle.gd"),
	"begin":preload("res://GameStates/begin.gd"),
	"popup_content_menu":preload("res://GameStates/popup_content_menu.gd"),
	"layers":preload("res://GameStates/layers.gd"),
}


func _enter_tree():
	
	_script_helper.set_name("_script_helper")
	add_child(_script_helper,true)

func append_state(_s,os=false):
	
	set_process(true)
	if !_state.has(_s) and !os:
		_state.append(_s)
		_script_helper.set_script(States[_s])
		_script_helper.call(_s)
	elif os:
		_script_helper.set_script(States[_s])
		_script_helper.call(_s)

func free_state(_s):
	
	if _state.has(_s):
		_state.erase(_s)
		if _state.empty():
			_state = ["idle"]
		_script_helper.set_script(States[_s])
		_script_helper.call(str("e_"+_s))

func set_state(_s):
	
	set_process(true)
	for s in _state:
		_script_helper.set_script(States[s])
		_script_helper.call(str("e_"+s))
	_state = _s
	for s in _state:
		_script_helper.set_script(States[s])
		_script_helper.call(str(s))

func _process(delta):
	
	_mp = Global.Game.get_global_mouse_pos()
	_lmp = get_tree().get_root().get_mouse_pos()
	Global.UI.update()
	if _state != ["idle"]:
		set_process(true)
		set_process_unhandled_input(true)
		for _s in _state:
			_script_helper.set_script(States[_s])
			_script_helper.call(str("p_"+_s))
	else:
		set_process(false)
		set_process_unhandled_input(false)
	
	klick[0] = false
	klick[1] = Vector2(-1,-1)

var _klicked

var __was_pressed = false
func _unhandled_input(event):
	
	if event.type==InputEvent.MOUSE_BUTTON:
		if event.is_pressed() == true:
			__was_pressed = true
		elif event.is_pressed()==false and event.button_index==1 and __was_pressed == true:
			klick[0] = "l"
			klick[1] = event.global_pos
			__was_pressed = false
		elif event.is_pressed()==false and event.button_index==2 and __was_pressed == true:
			klick[0] = "r"
			klick[1] = event.global_pos
			__was_pressed = false
