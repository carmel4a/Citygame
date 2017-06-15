extends Node

var something = GameState.something # to get something form game state e.g. mouse pos

func NAME(): #setup game state
	pass
func p_NAME(): # in-game process of game state. Here should be conditions to
	pass			# quit it by GameState.free_state()
func e_NAME(): # called when quiting the state. Here should be set up 
	pass			# new state(s) by GameState.append_state() if any. If that was
					# last state, and no new state was passed, next state will be [idle]
