extends Node

onready var Game = get_node("/root/Game")
onready var UI = get_node("/root/Game/CanvasLayer/UI")
onready var Level = get_node("/root/Game/Level")

func set_IP(v):
	
	UI._update(["Stats/Label"])
	Game.acc_IP = v

func get_IP():
	
	return(Game.acc_IP)

func get_IP_diff():
	
	return(Game.dif_IP)

func set_IP_diff(v):
	
	UI._update(["Stats/Label"])
	Game.dif_IP = v

# x,y,where,what
func add_cell(c=[]):
	Level._add(c)
	