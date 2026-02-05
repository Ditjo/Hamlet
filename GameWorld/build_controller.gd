extends Node2D

@onready var build_menu: Buildmenu = $"../../HUD/Control/VBoxContainer/BottomBar/HBoxContainer/BuildMenu"
@onready var input_manager: InputManager = $"../InputManager"
@onready var tile_info_drawer: Drawer = %TileInfoDrawer


var structure_selected: String = ""

func _ready() -> void:
	build_menu.building_selected.connect(_on_structrue_selected)
	input_manager.tile_right_click.connect(_on_right_click_received)
	input_manager.tile_left_click.connect(_on_left_click_received)
	
func _on_structrue_selected(type: String) -> void:
	input_manager.set_structure_as_selected()
	structure_selected = type
	_close_tile_info_drawer()
	print("From Building Controller: " + type)

func _on_left_click_received(coords: Vector2i) -> void:
	print("Left Click Received. Placing Structure on: " + str(coords))
	#Do building placement here!

func _on_right_click_received() -> void:
	if !structure_selected.is_empty():
		structure_selected = ""
		print("From Building Controller: ")
	
func _close_tile_info_drawer() -> void:
	tile_info_drawer.close()
