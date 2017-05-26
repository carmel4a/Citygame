extends Node2D

# Seed
export(int) var vseed = -1

func new_game():
	
	random_seed()	
	GameState.set_state("begin")

func _enter_tree():
#	vseed = 1146044083 # to test seeds
	if vseed == -1:
		randomize()
		vseed = randi()
	seed(vseed)
	print ("Seed: ",vseed)
	add_user_signal("next_turn")
	
func _ready():
	
	new_game()
	Global.UI._update()

func _next_turn():
	
	GameState._Turn += 1
	emit_signal("next_turn")
	GameState.Auth[0] += GameState.Auth[1]
	GameState.pop[0] += GameState.pop[2]
	if GameState.pop[0] >= GameState.pop[1]:
		GameState.pop[2] = round(GameState.pop[2]/4)
	Popups.generate_turn_alerts()
	
func random_seed():
	vseed = randi()
	seed(vseed)
