extends Node

onready var Game = get_node("/root/Game")
onready var HUD = get_node("/root/Game/HUD")
onready var UI = get_node("/root/Game/HUD/UI")
onready var Level = get_node("/root/Game/Level")
onready var Helpers = get_node("/root/Game/Level/Helpers")
onready var Popups = get_node("/root/Game/HUD/UI/Popups")

onready var Entities = {\
"Grass":[preload("res://Entities/nature.gd")],\
"Trees":[preload("res://Entities/nature.gd")],\
"River":[preload("res://Entities/nature.gd")],\
"Road":[preload("res://Entities/infrastructure.gd")],\
#"Bridge":[],\
"House":[preload("res://Entities/buildings.gd")]
}
# Get Level._content by Vector2D
func content(vx,y = null):
	
	return(Level._content[vx.x][vx.y])

