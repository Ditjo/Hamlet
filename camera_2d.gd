extends Camera2D

@export var move_speed: float = 600.0
@export var edge_margin: int = 20
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 1.0
@export var max_zoom: float = 2.5

@export var tilemap_layer: TileMapLayer

var world_bounds: Rect2

func _ready() -> void:
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	
	await get_tree().process_frame
	
	setup_camera_limits()
	
func setup_camera_limits():
	if not tilemap_layer:
		return
	
	var used_rect: Rect2i = tilemap_layer.get_used_rect()
	var tile_map_size: = tilemap_layer.tile_set.tile_size
	
	limit_left = used_rect.position.x
	limit_top = used_rect.position.y * tile_map_size.y
	limit_right = (used_rect.position.x + used_rect.size.x) * tile_map_size.x
	limit_bottom = (used_rect.position.y + used_rect.size.y) * tile_map_size.y
	
func _process(delta: float) -> void:
	_move_camera(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom_camera(-zoom_speed)
	
func _move_camera(delta: float) -> void:
	var direction := Vector2.ZERO
	
	#keyboard movement
	if Input.is_action_pressed("camera_right"):
		direction.x += 1
	if Input.is_action_pressed("camera_left"):
		direction.x -= 1
	if Input.is_action_pressed("camera_down"):
		direction.y += 1
	if Input.is_action_pressed("camera_up"):
		direction.y -= 1
	#direction.x = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	#direction.y = Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")

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
	
	var mouse_world_before: Vector2 = get_global_mouse_position()
	
	var new_zoom: Vector2 = zoom + Vector2(amount, amount) 
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	
	if new_zoom == zoom:
		return
	
	zoom = new_zoom
	
	var mouse_world_after: Vector2 = get_global_mouse_position()
	
	global_position += mouse_world_before - mouse_world_after
	
	
##region World Bounds
#func get_world_bounds(tilemap: TileMapLayer) -> Rect2:
	#var used: Rect2i = tilemap.get_used_rect()
	#if used.size == Vector2i.ZERO:
		#return Rect2()
	#
	#var tile_size: Vector2 = tilemap.tile_set.tile_size
	#
	#var local_pos: Vector2 = Vector2(used.position) * tile_size
	#var local_size: Vector2 = Vector2(used.size) * tile_size
	#var world_pos: = tilemap.to_global(local_pos)
	#
	#return Rect2(world_pos, local_size)
	#
#func _update_camera_limits() -> void:
	#var viewport_size: Vector2 = get_viewport_rect().size
	#var half_view: Vector2 = (viewport_size * 0.5)  / zoom
	#
	#limit_left = world_bounds.position.x - half_view.x
	#limit_top = world_bounds.position.y - half_view.y
	#limit_right = world_bounds.position.x + world_bounds.size.x - half_view.x
	#limit_bottom = world_bounds.position.y + world_bounds.size.y - half_view.y
	#
	##var viewport_size: Vector2 = get_viewport_rect().size
	##var view_size: Vector2 = viewport_size  / zoom
	##
	##limit_left = world_bounds.position.x
	##limit_top = world_bounds.position.y
	##limit_right = world_bounds.position.x + world_bounds.size.x - view_size.x
	##limit_bottom = world_bounds.position.y + world_bounds.size.y - view_size.y
	#
#func _clamp_to_world() -> void:
	#if world_bounds.size == Vector2.ZERO:
		#return
	#
	#var viewport_size: Vector2 = get_viewport_rect().size
	##var half_view: = viewport_size * 0.5 * zoom
	#var half_view: Vector2 = (viewport_size * 0.5) / zoom
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
