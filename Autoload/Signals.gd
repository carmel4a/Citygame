extends Node

func _ready():
	add_user_signal("emited")
	add_user_signal("next_turn")
	add_user_signal("Cancel")
	add_user_signal("adding_to_map")

func emit(n):
	emit_signal(n)
	emit_signal("emited",n)
	