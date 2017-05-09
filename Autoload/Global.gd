extends Node

onready var Game = get_node("/root/Game")
onready var UI = get_node("/root/Game/HUD/UI")
onready var Level = get_node("/root/Game/Level")

onready var Entities = {\
"Grass":[preload("res://Entities/nature.gd")],\
"Trees":[preload("res://Entities/nature.gd")],\
"River":[preload("res://Entities/nature.gd")],\
"Road":[preload("res://Entities/infrastructure.gd")],\
#"Bridge":[],\
"House":[preload("res://Entities/buildings.gd")]
}

func content(v):
	
	return(Level._content[v.x][v.y])

func _ready():
	
	add_user_signal("done")

func done():
	
	emit_signal("done")
