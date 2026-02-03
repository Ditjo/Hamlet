extends Camera2D

@export var move_speed: float = 600.0
@export var edge_margin: int = 20
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 1.0
@export var max_zoom: float = 2.5

#@export var tilemap_layer: TileMapLayer
#
#var world_bounds: Rect2
#
#func _ready() -> void:
	#world_bounds = get_world_bounds(tilemap_layer)

func _process(delta: float) -> void:
	_move_camera(delta)
	#_clamp_to_world()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom_camera(-zoom_speed)
	
func _move_camera(delta: float) -> void:
	var direction := Vector2.ZERO
	
	#keyboard movement
	direction.x = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	direction.y = Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")

	#Mouse movement
	var mouse_pos := get_viewport().get_mouse_position()
	var screen_size := get_viewport_rect().size
	
	if mouse_pos.x <= edge_margin:
		direction.x -= 1
	elif mouse_pos.x >= screen_size.x - edge_margin:
		direction.x += 1
	
	if mouse_pos.y <= edge_margin:
		direction.y -= 1
	elif mouse_pos.y >= screen_size.y - edge_margin:
		direction.y += 1
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		global_position += direction * move_speed * delta

func _zoom_camera(amount: float) -> void:
	var new_zoom := zoom + Vector2(amount, amount) 
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	zoom = new_zoom
	
##region World Bounds
#func get_world_bounds(tilemap: TileMapLayer) -> Rect2:
	#var used: Rect2i = tilemap.get_used_rect()
	#var tile_size: Vector2i = tilemap.tile_set.tile_size
	#
	#var world_pos: Vector2 = used.position * tile_size
	#var world_size: Vector2 = used.size * tile_size
	#
	#return Rect2(world_pos, world_size)
	#
#func _clamp_to_world() -> void:
	#var viewport_size: Vector2 = get_viewport_rect().size
	#var half_view: = viewport_size * 0.5 * zoom
		#
	#global_position.x = clamp(
		#global_position.x,
		#world_bounds.position.x + half_view.x,
		#world_bounds.position.x + world_bounds.size.x - half_view.x
	#)
	#
	#global_position.y = clamp(
		#global_position.y,
		#world_bounds.position.y + half_view.y,
		#world_bounds.position.y + world_bounds.size.y - half_view.y
	#)
##endregion
