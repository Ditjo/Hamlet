extends Node2D

#TileMapLayers
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var natur_layer: TileMapLayer = $"../TileMaps/NaturLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"

#Tile Infor Panel
@onready var tile_info_drawer: Drawer = %TileInfoDrawer
@onready var tile_info_panel: TileInfoPanel = %TileInfoPanel

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos: Vector2 = event.position
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				handle_tile_click(mouse_pos)
			MOUSE_BUTTON_RIGHT:
				_close_tile_info_drawer()

func handle_tile_click(mouse_pos: Vector2) -> void:
	var local_pos = background_layer.to_local(mouse_pos)
	var tile_coords = background_layer.local_to_map(local_pos)
	
	check_layer(tile_coords)

func check_layer(coords: Vector2i) -> void:
	if structure_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on structure_layer Layer
		print("structure_layer: ", coords)
		_open_tile_info_drawer("structure_layer" + str(coords))
		return
		
	if natur_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on natur_layer Layer
		print("natur_layer: ", coords)
		_open_tile_info_drawer("natur_layer" + str(coords))
		return
	
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
	if tile_info_drawer.is_open:
		tile_info_drawer.close()
