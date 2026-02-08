extends Node2D

#TileMaps
@onready var background_layer: TileMapLayer = $"../TileMaps/BackgroundLayer"
@onready var nature_layer: TileMapLayer = $"../TileMaps/NatureLayer"
@onready var structure_layer: TileMapLayer = $"../TileMaps/StructureLayer"


@onready var build_menu: Buildmenu = $"../../HUD/Control/VBoxContainer/BottomBar/HBoxContainer/BuildMenu"
@onready var input_manager: InputManager = $"../InputManager"
@onready var tile_info_drawer: Drawer = %TileInfoDrawer




var structure_selected: Enums.StructureTypes = Enums.StructureTypes.ZERO

func _ready() -> void:
	build_menu.building_selected.connect(_on_structrue_selected)
	input_manager.tile_right_click.connect(_on_right_click_received)
	input_manager.tile_left_click.connect(_on_left_click_received)
	
func _on_structrue_selected(type: Enums.StructureTypes) -> void:
	input_manager.set_structure_as_selected()
	structure_selected = type
	_close_tile_info_drawer()
	#print("From Building Controller: " + type)

func _on_left_click_received(coords: Vector2i) -> void:
	#print("Left Click Received. Placing Structure on: " + str(coords))
	#Do building placement here!
	#Check if building can be placed!
	var s: Structures = _get_new_building_of_choosen_type(structure_selected)
	if s == null:
		print("Strucutre Not Found")
	elif !_is_tile_free(coords):
		print("Tile occupied: " + str(coords))
	elif !s.can_build_object():
		print("Not enough gold")
	else:
		DataManager.remove_gold(s.cost.get(Enums.CostTypes.GOLD))
		DataManager.add_structure(coords, s)
		structure_layer.set_cell(coords, s.atlas_source_id, s.atlas_coords)

	#if _is_tile_free(coords):
		##var s: Structures = _get_new_building_of_choosen_type(structure_selected)
		#if s:
			#if s.can_build_object():
				#DataManager.add_structure(coords, s)
				#structure_layer.set_cell(coords, s.atlas_source_id, s.atlas_coords)
			#else:
				#print("Not enough gold")
		#else: 
			#print("Strucutre Not Found")
	#else:
		#print("Tile occupied: " + str(coords))

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
