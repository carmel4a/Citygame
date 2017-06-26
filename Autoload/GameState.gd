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
var _acct_process_state

var States={\
	"idle":preload("res://GameStates/idle.gd"),
	"begin":preload("res://GameStates/begin.gd"),
	"popup_content_menu":preload("res://GameStates/popup_content_menu.gd"),
	"layers":preload("res://GameStates/layers.gd"),
	"adding_to_map":preload("res://GameStates/adding_to_map.gd"),
}

func _enter_tree():
	
	_script_helper.set_name("_script_helper")
	add_child(_script_helper,true)
	set_process(true)
	set_process_unhandled_input(true)

func append_state(_s,args=null,os=false):
	
	if !_state.has(_s) and !os:
		_state.append(_s)
		_script_helper.set_script(States[_s])
		if args == null: args = []
		_script_helper.callv(str(_s),args)
		print("called: ",_s)
	elif os:
		if args == null: args = []
		_script_helper.set_script(States[_s])
		_script_helper.callv(str(_s),args)

func free_state(_s):
	
	if _state.has(_s):
		_state.erase(_s)
		if _state.empty():
			_state = ["idle"]
		_script_helper.set_script(States[_s])
		_script_helper.call(str("e_"+_s))

func set_state(_s):
	
	for s in _state:
		_script_helper.set_script(States[s])
		_script_helper.call(str("e_"+s))
	_state = _s
	for s in _state:
		_script_helper.set_script(States[s])
		_script_helper.call(str(s))

func idle_state():
	
	for s in _state:
		_script_helper.set_script(States[s])
		_script_helper.call(str("e_"+s))
	_state = ["idle"]

var _saved_states = {}
func save_state(dict):
	
	_saved_states[_acct_process_state] = dict

func load_state():
	
	if _saved_states.has(_acct_process_state):
		for i in _saved_states[_acct_process_state]:
			_script_helper.set(i,_saved_states[_acct_process_state][i])

func _process(delta):
	
	_mp = Global.Game.get_global_mouse_pos()
	_lmp = get_tree().get_root().get_mouse_pos()
	Global.UI.update()
	if _state != ["idle"]:
		set_process(true)
		set_process_unhandled_input(true)
		for _s in _state:
			_acct_process_state = _s
			_script_helper.set_script(States[_s])
			_script_helper.call(str("p_"+_s))
	klick = [false,Vector2(-1,-1)]

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
