extends PanelContainer
class_name TileInfoPanel

signal delete_pressed()

@onready var title: Label = $VBox/BaseinfoSection/Title
@onready var description: Label = $VBox/BaseinfoSection/PanelContainer/Description

@onready var people_section: VBoxContainer = $VBox/PeopleSection

@onready var people_info: Label = $VBox/PeopleSection/PeopleDisplay/PeopleInfo
@onready var person_controls: HBoxContainer = $VBox/PeopleSection/PeopleDisplay/PersonControls
@onready var remove_person_btn: Button = $VBox/PeopleSection/PeopleDisplay/PersonControls/RemovePersonBtn
@onready var spacer: PanelContainer = $VBox/PeopleSection/PeopleDisplay/PersonControls/Spacer
@onready var add_person_btn: Button = $VBox/PeopleSection/PeopleDisplay/PersonControls/AddPersonBtn

@onready var person_list_container: PanelContainer = $VBox/PeopleSection/PersonListContainer

@onready var delete_btn: Button = $VBox/DeleteSection/MarginContainer/DeleteBtn

var is_structure: bool = false
var structure: Structures = null
var object: MapObjects = null
var coords: Vector2i = Vector2i.ZERO

func set_info_panel(object_: MapObjects, coords_: Vector2i = Vector2i(-1,-1)) -> void:
	people_section.visible = false
	person_controls.visible = false
	is_structure = false
	structure = null
	object = object_
	coords = coords_
	delete_btn.text = "Delete: %d gold" % object.get_removal_cost()
	
	title.text = object.object_name
	description.text = object.description
	remove_person_btn.pressed.connect(_on_remove_person)
	add_person_btn.pressed.connect(_on_add_person)
	delete_btn.pressed.connect(_on_delete_object)
	DataManager.population_changed.connect(_on_population_changed)
	
	if coords != Vector2i(-1,-1):
		is_structure = true
		people_section.visible = true
		structure = DataManager.get_structure_by_coords(coords)
		_build_people_list(structure)
	
	_update_ui()

func _build_people_list(struct: Structures) -> void:
	for child in person_list_container.get_children():
		child.queue_free()
	
	var people: Array[Person] = []
	var people_count: int = 0
	if struct is JobStructures:
		people_info.text = "Workers %d/%d" % [struct.get_current_worker_count(), struct.max_workers]
		people = struct.currentWorkers
		people_count = struct.max_workers
		person_controls.visible = true
	elif struct is HousingStructures:
		people_info.text = "Occupants %d/%d" % [struct.get_current_house_population(), struct.max_people]
		people = struct._people
		people_count = struct.max_people
	var person_list: VBoxContainer = VBoxContainer.new()
	person_list.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for p in people_count:
		var personPanel: PanelContainer = PanelContainer.new()
		personPanel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		if people.size() > p:
			var person_info_label: PersonInfoLabel = preload("res://UI/Shared/PersonInfoLabel.tscn").instantiate()
			personPanel.add_child(person_info_label)
			person_info_label.set_person(people[p])
		else:
			var empty_person_label: Label = Label.new()
			personPanel.add_child(empty_person_label)
			var style = load("res://Assets/PanelTexture.tres")
			personPanel.add_theme_stylebox_override("panel", style)
			empty_person_label.text = "Free"
		var margin: = MarginContainer.new()
		margin.size_flags_vertical = Control.SIZE_EXPAND_FILL
		margin.add_theme_constant_override("margin_left", 3)
		margin.add_theme_constant_override("margin_right", 3)
		margin.add_theme_constant_override("margin_top", 3)
		margin.add_theme_constant_override("margin_bottom", 3)
		margin.add_child(personPanel)
		person_list.add_child(margin)
	person_list_container.add_child(person_list)

func _update_ui() -> void:
	delete_btn.disabled = _can_object_be_deleted()
	delete_btn.visible = _show_delete_btn()
	if is_structure:
		_build_people_list(structure)
		remove_person_btn.disabled = _can_remove_be_pressed()
		add_person_btn.disabled = _can_add_be_pressed()

func _on_population_changed(pop: int) -> void:
	_update_ui()

func _on_add_person() -> void:
	if structure is JobStructures:
		var p = DataManager.get_jobless_person()
		structure.add_worker(p)
		p.job = coords
	_update_ui()

func _can_add_be_pressed() -> bool:
	if structure is JobStructures:
		return !structure.currentWorkers.size() < structure.max_workers or\
		!DataManager.get_jobless_person() != null
	return true

func _on_remove_person() -> void:
	if structure is JobStructures:
		structure.remove_worker(structure.get_current_worker_count() - 1)
	_update_ui()

func _can_remove_be_pressed() -> bool:
	if structure is JobStructures:
		return !structure.currentWorkers.size() > 0
	return true

func _on_delete_object() -> void:
	DataManager.remove_gold(object.get_removal_cost())
	DataManager.remove_structure(coords)
	delete_pressed.emit()

func _can_object_be_deleted() -> bool:
	return !object.can_delete_object()

func _show_delete_btn() -> bool:
	return object.map_object_type == Enums.MapObjectTypes.STRUCTURES or\
	object.map_object_type == Enums.MapObjectTypes.TREES or\
	object.map_object_type == Enums.MapObjectTypes.ROCKS
