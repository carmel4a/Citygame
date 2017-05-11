extends Node

func add_entitie(what,args):
	if Global.Entities.has(what):
		var _e = Global.Entities[what][0].new()
		var _c = _e.get(what).new()
		_c.init(args)
		if _c._ready():
			return(true)
		else:
			return(false)
