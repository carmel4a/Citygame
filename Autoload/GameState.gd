extends Node

var _Turn = 0
# authority
var _Auth  = 10
# difference of authority per turn
var _d_Auth = 5
var pop = [] # acc, delta, max

func set_Auth_diff(v):
	
	_d_Auth = v
	Global.UI._update(["Stats/Label"])

func set_Auth(v):
	
	_Auth = v
	Global.UI._update(["Stats/Label"])
