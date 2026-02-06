extends Node2D

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
	print("Left Click Received. Placing Structure on: " + str(coords))
	#Do building placement here!
	
	#Add buildings to Strucutr in datamanager
	var s: Structures = _get_new_building_of_choosen_type(structure_selected)
	DataManager.add_structure(coords, s)
	#DataManager.add_structure(h)
	#Place Buildings on the right tile

func _on_right_click_received() -> void:
	if structure_selected != Enums.StructureTypes.ZERO:
		structure_selected = Enums.StructureTypes.ZERO
		print("From Building Controller: ")
	
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()

func _get_new_building_of_choosen_type(type: Enums.StructureTypes) -> Structures:
	match type:
		Enums.StructureTypes.HOUSE:
			return House.new()
		#Enums.StructureTypes.FIELD:
			#pass
		#Enums.StructureTypes.WINDMILL:
			#pass
		_:
			return null
