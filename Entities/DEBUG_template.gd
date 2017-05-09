extends Node

class Class:
	
	var _done = false
	
	func init(xy):
		_done = true

	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
