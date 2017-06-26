# Main game node (main menu, etc should have other).
# Only main features as next turn handling, creating new game.

extends Node2D

# Seed
export(int) var vseed = -1

var _next_turn_thread = Thread.new()
var threads = [_next_turn_thread]
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

func _on_next_turn():
	
	if !threads[0].is_active():
		threads[0].start(self, "_next_turn", null)
	else:
		print("Error: Something went wrong in _on_next_turn in Game.gd")

func _next_turn(data):
	
	var _prev_state = GameState._state
	GameState.idle_state()
	Global.UI.get_node("Stats/NextTurn").set_disabled(true)
	Global.Popups.get_node("TurnProcessing").show()
	# Global updates witch NOT depens on other objs/entities,etc.
	GameState._Turn += 1
	GameState.Auth[0] += GameState.Auth[1]
	GameState.pop[2] = 0
	# Here objests should do auto update
	# Note that object must connect to Signals to use that signal
	while Signals.blocade:
		continue
	Signals.emit("pre_next_turn")
	while Signals.blocade:
		continue
	Signals.emit("next_turn")
	while Signals.blocade:
		continue
	Global.Popups.generate_turn_alerts()
	Global.UI.update()
	Global.UI.get_node("Stats/NextTurn").set_disabled(false)
	Global.Popups.get_node("TurnProcessing").hide()
	GameState.set_state(_prev_state)
	threads[0].wait_to_finish()
	return(true)

func _random_seed():
	
	vseed = randi()
	seed(vseed)
