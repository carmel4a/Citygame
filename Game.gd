extends Node2D

func _enter_tree():
	
	randomize()

func _next_turn():
	
	GameState._Turn += 1
	GameState.set_Auth(GameState._Auth + GameState._d_Auth)
	Popups.generate_turn_alerts()
