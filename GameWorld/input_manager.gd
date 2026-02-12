extends Node2D
class_name InputManager

##TileMapLayers
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"

@onready var tile_info_controller: TileInfoController = $"../TileInfoController"

signal tile_left_click(coords: Vector2i)
signal tile_right_click()

var _is_structure_selected_in_buildmenu: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos: Vector2 = get_local_mouse_position()
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				handle_left_click(mouse_pos)
			MOUSE_BUTTON_RIGHT:
				handle_right_click()

func set_structure_as_selected() -> void:
	_is_structure_selected_in_buildmenu = true

func handle_left_click(mouse_pos: Vector2) -> void:
	#Layers might get out of sync with each other. 
	#If that is the case, need to rework how the to check if things exist on a layer
	var local_pos: Vector2 = background_layer.to_local(mouse_pos)
	var tile_coords: Vector2i = background_layer.local_to_map(local_pos)
	
	if _is_structure_selected_in_buildmenu:
		tile_left_click.emit(tile_coords)
	else:
		tile_info_controller.find_map_object(tile_coords)

func handle_right_click() -> void:
	tile_info_controller._close_tile_info_drawer()
	tile_right_click.emit()
	_is_structure_selected_in_buildmenu = false
