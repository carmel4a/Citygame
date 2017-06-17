# Main game node (main menu, etc should have other).
# Only main features as next turn handling, creating new game.

extends Node2D

# Seed
export(int) var vseed = -1

func _enter_tree():
	
#	vseed = 1146044083 # to test seeds
	if vseed == -1:
		randomize()
		vseed = randi()
	seed(vseed)
	#DEBUG
	print ("Seed: ",vseed)
	#/DEBUG

func _ready():
	
	new_game()

func new_game():
	
	_random_seed()
	Global.UI.update()
	GameState.set_state(["begin"])

func next_turn():
	
	# Global updates witch NOT depens on other objs/entities,etc.
	GameState._Turn += 1
	GameState.Auth[0] += GameState.Auth[1]
	GameState.pop[2] = 0
	# Here objests should do auto update
	# Note that object must connect to Game to use that signal
	Signals.emit("pre_next_turn")
	Signals.emit("next_turn")
	Global.Popups.generate_turn_alerts()
	Global.UI.update()

func _random_seed():
	vseed = randi()
	seed(vseed)
