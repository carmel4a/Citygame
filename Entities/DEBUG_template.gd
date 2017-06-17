extends Node

class Class:
	
	var _done = false
	
	func init(x, y, z = ""):
		_done = true

	func _ready():
		
		if _done:
			return(true)
		else:
			return(false)
