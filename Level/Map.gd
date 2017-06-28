extends Node2D

var chunk_size = 640 # 10 tiles, 64px each

var _bt = ImageTexture.new()
var _chunks_rect
var _phase = 1
var _tex = LargeTexture.new()
var _tilemaps_arr
var _to_update = []

onready var _map_size
onready var _tilemaps = get_node("../TileMapsViewport")
onready var _tile_size

var __time

func _ready():
	
	_map_size = Global.Level.map_size
	_tile_size = Global.Level.tile_size
	_tilemaps_arr = _tilemaps.get_children()
	chunk_size = Vector2(_tile_size*10,_tile_size*10) # 10 tiles, 64px each
	var _im = Image(chunk_size.x,chunk_size.y,false,Image.FORMAT_RGBA)
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			 _im.put_pixel(x,y,Color(0,0,0,0))
	_bt.create_from_image(_im,0)
	_tex.add_piece(Vector2(0,0),_bt)
	for y in range(floor(_map_size.x*_tile_size/chunk_size.x)):
		for x in range(floor(_map_size.y*_tile_size/chunk_size.y)):
			_tex.add_piece(chunk_size*Vector2(x,y),_bt)

func draw_chunk(ch_pos,vtex):
	
	_tex.set_piece_texture(1+(ch_pos.y*floor(chunk_size.x/_tile_size))+ch_pos.x,vtex)

func draw_all(vtex):
	
	_tex.set_piece_texture(0,vtex)
	for i in range(1,_tex.get_piece_count()):
		_tex.set_piece_texture(i,_bt)

func draw_chunks(rect2,vtex):
	
	for x in range(ceil(rect2.size.x/chunk_size.x)):
		for y in range(ceil(rect2.size.y/chunk_size.y)):
			var _IT = ImageTexture.new()
			_IT.create_from_image(vtex.get_rect(Rect2(Vector2(x,y)*chunk_size,\
			Vector2(chunk_size))),4096+2)
			draw_chunk(Vector2(x,y)+(rect2.pos/chunk_size).floor(),
			_IT)

func _draw():
	
	draw_texture(_tex,Vector2(0,0))
# rect2 has global vars
func _map_updaded(rect2=null):
	
	__time = OS.get_ticks_msec()
	_to_update = null
	if rect2 == null:
		_to_update = Rect2(Vector2(0,0),_map_size*_tile_size)
	else:
		if typeof(_to_update)==TYPE_RECT2:
			_to_update = _to_update.merge(rect2)
		else:
			_to_update = rect2
	_tilemaps.set_render_target_update_mode(4)
	for i in _tilemaps_arr:
		i.show()
		i.set_cell(-i.get_index()-2,-1,0)
#		i.update()
	_tilemaps.set_canvas_transform(Matrix32(0,Vector2((_tilemaps.get_child_count()+1)*_tile_size,1)))
	_tilemaps.set_rect(Rect2(\
	Vector2(0,0),\
	Vector2(_tilemaps.get_child_count()*_tile_size,1)))
	_tilemaps.queue_screen_capture()
	set_process(true)

func _process(delta):
	
	var ready = true
	var screen = _tilemaps.get_screen_capture()
	if screen.empty(): return
	_tilemaps.queue_screen_capture()
	if _phase == 1:
		for x in range(_tilemaps_arr.size()):
			if screen.get_pixel(x*_tile_size,0) == Color(0.0,0.0,0.0,0.0):
				return
#		for x in range(screen.get_width()):
#			if screen.get_pixel(x,0) == Color(0.0,0.0,0.0,0.0):
#				ready = false	
		_chunks_rect = Rect2(\
		(_to_update.pos/chunk_size).floor()*chunk_size,\
		Vector2(ceil((_to_update.size.x/chunk_size.x))*chunk_size.x,ceil((_to_update.size.y/chunk_size.y))*chunk_size.y))
		_tilemaps.set_canvas_transform(Matrix32(0,-_chunks_rect.pos))
		_tilemaps.set_rect(Rect2(Vector2(0,0),_chunks_rect.size))
		_phase = 2
	elif _phase == 2:
		if _chunks_rect == Rect2(Vector2(0,0),_tile_size*_map_size):
			var _tex2 = ImageTexture.new()
			_tex2.create_from_image(screen,4096+2)
			draw_all(_tex2)
		else:
			draw_chunks(_chunks_rect,screen)
#			_tilemaps.set_canvas_transform(Matrix32(0,-_chunks_rect.pos))
		update()
		_tilemaps.set_canvas_transform(Matrix32(0,Vector2((_tilemaps.get_child_count()+1)*_tile_size,1)))
		_tilemaps.set_rect(Rect2(Vector2(0,0),Vector2(_tilemaps.get_child_count()*_tile_size,1)))
		_tilemaps.set_render_target_update_mode(1)
		_phase = 3
		for i in _tilemaps_arr:
			i.set_cell(-i.get_index()-2,-1,-1)
#			i.update()
	elif _phase == 3:
#		for x in range(screen.get_width()):
#			if screen.get_pixel(x,0) != Color(0.0,0.0,0.0,0.0):
#				_tilemaps.render_target_clear()
		for x in range(_tilemaps_arr.size()):
			if screen.get_pixel(x*_tile_size,0) != Color(0.0,0.0,0.0,0.0):
				return
		for i in _tilemaps_arr:
			i.hide()
		_tilemaps.set_render_target_update_mode(0)
		_phase = 1
		set_process(false)
		print("END: ",OS.get_ticks_msec()- __time)