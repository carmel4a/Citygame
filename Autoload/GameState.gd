extends Node

var _Turn = 0
# authority
var _Auth  = 10
# difference of authority per turn
var _d_Auth = 0

func set_IP_diff(v):
	
	Global.UI._update(["Stats/Label"])
	_d_Auth = v

func set_IP(v):
	
	Global.UI._update(["Stats/Label"])
	_Auth = v
