extends Camera2D

@export var move_speed: float = 800.0
@export var edge_margin: int = 20
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 1.0
@export var max_zoom: float = 2.5

@export var tilemap_layer: TileMapLayer

func _ready() -> void:
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	
	var used_rect: Rect2i = tilemap_layer.get_used_rect()
	var tile_map_size: Vector2i = tilemap_layer.tile_set.tile_size
	
	global_position = Vector2(240, 160)

	limit_left = used_rect.position.x # usally 0
	limit_right = used_rect.size.x * tile_map_size.x
	limit_top =  used_rect.position.y # usally 0
	limit_bottom = used_rect.size.y * tile_map_size.y
	
func _process(delta: float) -> void:
	if !GameManager.is_paused:
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
		global_position += clamp_movement(direction * move_speed * delta)

func clamp_movement(delta_pos: Vector2) -> Vector2:
	if (global_position.x <= limit_left and delta_pos.x < 0) or (global_position.x >= limit_right and delta_pos.x > 0):
		delta_pos.x = 0
	if (global_position.y <= limit_top and delta_pos.y < 0) or (global_position.y >= limit_bottom and delta_pos.y > 0):
		delta_pos.y = 0
	return delta_pos

func _zoom_camera(amount: float) -> void:
	if GameManager.is_paused:
		return
		
	var mouse_world_before: Vector2 = get_global_mouse_position()
	
	var new_zoom: Vector2 = zoom + Vector2(amount, amount) 
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	
	if new_zoom == zoom:
		return
	
	zoom = new_zoom
	
	var mouse_world_after: Vector2 = get_global_mouse_position()
	
	global_position += mouse_world_before - mouse_world_after
