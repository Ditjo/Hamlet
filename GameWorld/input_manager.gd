extends Node2D
class_name InputManager

#TileMapLayers
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var nature_layer: TileMapLayer = $"../TileMaps/NatureLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"

#Tile Info Panel
@onready var tile_info_drawer: Drawer = %TileInfoDrawer
@onready var tile_info_panel: TileInfoPanel = %TileInfoPanel

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
		check_layer(tile_coords)

func handle_right_click() -> void:
	_close_tile_info_drawer()
	tile_right_click.emit()
	_is_structure_selected_in_buildmenu = false


#NEED TO MOVE THIS FUNCTION OUT FROM HERE TO ANOTHER SCRIPT!!!!
func check_layer(coords: Vector2i) -> void:
	print("structure_layer: " + str(structure_layer.get_cell_source_id(coords)))
	if structure_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on structure_layer Layer
		print("structure_layer: ", coords)
		_open_tile_info_drawer("structure_layer" + str(coords))
		return
	
	print("nature_layer: " + str(nature_layer.get_cell_source_id(coords)))
	if nature_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on natur_layer Layer
		print("natur_layer: ", coords)
		
		#Get data; Check if not null & has custom data called "name"; Get it; Show it.
		var data:TileData = nature_layer.get_cell_tile_data(coords)
		if data and data.has_custom_data("type_id"):
			var d = data.get_custom_data("type_id")
			print("nature_layer: " + str(d))
			
		_open_tile_info_drawer("nature_layer" + str(coords))
		return
		
	print("background_layer: " + str(background_layer.get_cell_source_id(coords)))
	if background_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on background_layer Layer
		print("background_layer: ", coords)
		_open_tile_info_drawer("background_layer" + str(coords))
		return

func _open_tile_info_drawer(text: String) -> void:
	tile_info_panel.set_info_panel(text)
	if !tile_info_drawer.is_open:
		tile_info_drawer.toggle()
		
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()
