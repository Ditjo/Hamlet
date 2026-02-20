extends Node

#The Startup file
@onready var cheat_menu: CanvasLayer = $CheatMenu
@onready var build_controller: BuildController = $GameWorld/BuildController
@onready var new_game_menu: NewGameMenu = %NewGameMenu
@onready var drawer_main_menu: Drawer = %DrawerMainMenu

func _ready():
	cheat_menu.visible = false
	new_game_menu.new_game_started.connect(_set_up_start)
	DataManager.add_gold(50)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cheat_menu"):
		cheat_menu.visible = !cheat_menu.visible

#region Start Setup

var house_coords: Vector2i = Vector2i(42,19)
var field_coords: Vector2i = Vector2i(42,20)

var start_setup_structs = [
	{
		"type" : Enums.StructureTypes.HOUSE,
		"coords" : house_coords,
	},
	{
		"type" : Enums.StructureTypes.FIELD,
		"coords" : field_coords,
	}
]

var start_setup_people: Array[Person] = [
	Person.new(),
	Person.new()
]

func _set_up_start() -> void:
	#Setup Structures
	for s in start_setup_structs:
		build_controller.structure_selected = s.get("type")
		build_controller._on_left_click_received(s.get("coords"))
	
	#Setup People
	for p in start_setup_people:
		#Add to House
		var h = DataManager.get_house_w_space()
		var coords = DataManager.get_key_by_value(h)
		p.home = coords
		h.add_person_to_house(p)
		#Add to field
		var s: Structures = DataManager.get_structure_by_coords(field_coords)
		if s is JobStructures:
			p.job = field_coords
			s.add_worker(p)
		DataManager.add_person_to_population(p)
	GameManager.game_main()
#endregion
