extends Node2D
class_name BuildController
#TileMaps
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var nature_layer: TileMapLayer = $"../TileMaps/NatureLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"

@onready var build_menu: Buildmenu = $"../../HUD/Control/VBoxContainer/BottomBar/HBoxContainer/BuildMenu"
@onready var input_controller: InputManager = $"../InputController"
@onready var tile_info_controller: TileInfoController = $"../TileInfoController"

@onready var tile_info_drawer: Drawer = %TileInfoDrawer

@onready var tooltip: Tooltip = $"../../HUD/Tooltip"

var structure_selected: Enums.StructureTypes = Enums.StructureTypes.ZERO

func _ready() -> void:
	build_menu.building_selected.connect(_on_structrue_selected)
	input_controller.tile_right_click.connect(_on_right_click_received)
	input_controller.tile_left_click.connect(_on_left_click_received)
	tile_info_controller.deleted_pressed.connect(_on_delete_pressed)
	
func _on_structrue_selected(type: Enums.StructureTypes) -> void:
	input_controller.set_structure_as_selected()
	structure_selected = type
	_close_tile_info_drawer()

func _on_left_click_received(coords: Vector2i) -> void:
	#Check if building can be placed!
	var s: Structures = _get_new_building_of_choosen_type(structure_selected)
	if s == null:
		tooltip.show_tooltip("Strucutre Not Found")
		return
	elif !_is_tile_free(coords):
		tooltip.show_tooltip("Tile is occupied")
		return
	elif !s.can_build_object():
		tooltip.show_tooltip("Not enough gold")
		return
	else:
		DataManager.remove_gold(s.cost.get(Enums.CostTypes.GOLD))
		DataManager.add_structure(coords, s)
		structure_layer.set_cell(coords, s.atlas_source_id, s.atlas_coords)

func _on_right_click_received() -> void:
	if structure_selected != Enums.StructureTypes.ZERO:
		structure_selected = Enums.StructureTypes.ZERO
		print("From Building Controller: ")
	
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()

func _is_tile_free(coords: Vector2i) -> bool:
	#return true, if both layers don't have any objects on that tile.
	return structure_layer.get_cell_source_id(coords) == -1 and\
	 nature_layer.get_cell_source_id(coords) == -1

func _get_new_building_of_choosen_type(type: Enums.StructureTypes) -> Structures:
	match type:
		Enums.StructureTypes.HOUSE:
			return House.new()
		Enums.StructureTypes.FIELD:
			return Field.new()
		Enums.StructureTypes.WINDMILL:
			return Windmill.new()
		_:
			return null

func _on_delete_pressed(coords: Vector2i):
	if structure_layer.get_cell_source_id(coords) != -1:
		structure_layer.set_cell(coords)
	elif nature_layer.get_cell_source_id(coords) != -1:
		nature_layer.set_cell(coords)
		
