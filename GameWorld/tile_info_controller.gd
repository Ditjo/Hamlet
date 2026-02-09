extends Node2D
class_name  TileInfoController

#TileMapLayers
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var nature_layer: TileMapLayer = $"../TileMaps/NatureLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"

#Tile Info Panel
@onready var tile_info_drawer: Drawer = %TileInfoDrawer
@onready var tile_info_panel: TileInfoPanel = %TileInfoPanel

func check_layer(coords: Vector2i) -> void:
	if structure_layer.get_cell_source_id(coords) != -1:
		#Handle Tile on structure_layer Layer
		var map_object: MapObjects = _get_data_from_tile(structure_layer, coords, "script")
		if map_object == null:
			#If null then What? If anything? Maybe Just Remove?
			return
		_open_tile_info_drawer(map_object, coords)
		
		return
	if nature_layer.get_cell_source_id(coords) != -1:

		var map_object: MapObjects = _get_data_from_tile(nature_layer, coords, "script")
		
		if map_object != null:
			_open_tile_info_drawer(map_object)
		else:
			pass
			#If null then What? If anything? Maybe Just Remove?

		return
	if background_layer.get_cell_source_id(coords) != -1:
		
		var map_object: MapObjects = _get_data_from_tile(background_layer, coords, "script")
		
		if map_object != null:
			_open_tile_info_drawer(map_object)
		else:
			pass
		return

func _get_data_from_tile(tile_map_layer: TileMapLayer, coords: Vector2i, data_name: String) -> MapObjects:
	var map_object: MapObjects = null
	var data: TileData = tile_map_layer.get_cell_tile_data(coords)
	
	if data and data.has_custom_data(data_name):
		var script = data.get_custom_data(data_name)
		if script and script is MapObjects:
			map_object = script as MapObjects
	return map_object

func _open_tile_info_drawer(map_object: MapObjects, coords: Vector2i = Vector2i(-1,-1)) -> void:
	tile_info_panel.set_info_panel(map_object, coords)
	if !tile_info_drawer.is_open:
		tile_info_drawer.toggle()
		
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()
