extends Node

func add_entitie(what,args):
	
	if Global.Entities.has(what):
		# Get from script in res://Entities
		var _e = Global.Entities[what][0].new()
		var _c = _e.get(what).new()
		_c.callv("init",args)
		if _c._ready():
			return(true)
		else:
			return(false)
	print("Error: Wrong name of entitie: "+str(what))
	return (false)