extends Node2D

# Seed
export(int) var vseed = -1

func new_game():
	
	random_seed()	
	GameState.set_state("begin")

func _enter_tree():
	
	if vseed == -1:
		randomize()
		vseed = randi()
	seed(vseed)

func _ready():
	
	new_game()

func _next_turn():
	
	GameState._Turn += 1
	GameState.set_Auth(GameState._Auth + GameState._d_Auth)
	Popups.generate_turn_alerts()

func random_seed():
	vseed = randi()
	seed(vseed)
