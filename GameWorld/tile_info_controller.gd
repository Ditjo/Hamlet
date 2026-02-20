extends Node2D
class_name  TileInfoController

signal deleted_pressed(coords_: Vector2i)

#TileMapLayers
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var nature_layer: TileMapLayer = $"../TileMaps/NatureLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"

#Tile Info Panel
@onready var tile_info_drawer: Drawer = %TileInfoDrawer
@onready var tile_info_panel: TileInfoPanel = %TileInfoPanel

var coords: Vector2i = Vector2i.ZERO

func _ready() -> void:
	tile_info_panel.delete_pressed.connect(_on_delete_pressed)
	
func find_map_object(coords_: Vector2i) -> void:
	coords = coords_
	var object: MapObjects = check_layer(coords_)
	if object == null:
		tile_info_drawer.close()
		return
	if object.map_object_type == Enums.MapObjectTypes.STRUCTURES:
		_open_tile_info_drawer(object, coords)
	else:
		_open_tile_info_drawer(object)

func check_layer(coords_: Vector2i) -> MapObjects:
	if structure_layer.get_cell_source_id(coords_) != -1:
		return _get_data_from_tile(structure_layer, coords_, "script")
	elif nature_layer.get_cell_source_id(coords_) != -1:
		return _get_data_from_tile(nature_layer, coords_, "script")
	elif background_layer.get_cell_source_id(coords_) != -1:
		return _get_data_from_tile(background_layer, coords_, "script")
		
	return null

func _get_data_from_tile(tile_map_layer: TileMapLayer, coords_: Vector2i, data_name: String) -> MapObjects:
	var map_object: MapObjects = null
	var data: TileData = tile_map_layer.get_cell_tile_data(coords_)
	
	if data and data.has_custom_data(data_name):
		var script = data.get_custom_data(data_name)
		if script and script is MapObjects:
			map_object = script as MapObjects
	return map_object

func _open_tile_info_drawer(map_object: MapObjects, coords_: Vector2i = Vector2i(-1,-1)) -> void:
	tile_info_panel.set_info_panel(map_object, coords_)
	if !tile_info_drawer.is_open:
		tile_info_drawer.toggle()
		
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()

func _on_delete_pressed() -> void:
	deleted_pressed.emit(coords)
	_close_tile_info_drawer()
