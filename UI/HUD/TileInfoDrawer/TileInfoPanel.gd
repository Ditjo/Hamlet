extends PanelContainer
class_name TileInfoPanel

@onready var title: Label = $VBox/BaseinfoSection/Title
@onready var description: Label = $VBox/BaseinfoSection/PanelContainer/Description

@onready var people_display: HBoxContainer = $VBox/PeopleSection/PeopleDisplay
@onready var people_info: Label = $VBox/PeopleSection/PeopleDisplay/PeopleInfo
@onready var person_controls: HBoxContainer = $VBox/PeopleSection/PeopleDisplay/PersonControls
@onready var remove_person_btn: Button = $VBox/PeopleSection/PeopleDisplay/PersonControls/RemovePersonBtn
@onready var spacer: PanelContainer = $VBox/PeopleSection/PeopleDisplay/PersonControls/Spacer
@onready var add_person_btn: Button = $VBox/PeopleSection/PeopleDisplay/PersonControls/AddPersonBtn

@onready var person_list_container: PanelContainer = $VBox/PeopleSection/PersonListContainer

@onready var delete_btn: Button = $VBox/DeleteSection/DeleteBtn

var is_structure: bool = false	
var structure: Structures = null

func set_info_panel(object: MapObjects, coords: Vector2i = Vector2i(-1,-1)) -> void:
	person_controls.visible = false
	is_structure = false
	structure = null
	for child in person_list_container.get_children():
		child.queue_free()
	
	title.text = object.object_name
	description.text = object.description
	remove_person_btn.pressed.connect(_on_remove_person)
	add_person_btn.pressed.connect(_on_add_person)
	delete_btn.pressed.connect(_on_delete_object)
	
	_update_ui()
	
	if coords != Vector2i(-1,-1):
		is_structure = true
		structure = DataManager.get_structure_by_coords(coords)
		#if struct == null:
			#print("NO structure with Coords: " + str(coords))
		#structure = struct
		_build_people_list(structure)
	
	if object.can_delete_object():
		delete_btn.visible = true
	else:
		delete_btn.visible = false
		#Use this Area to Handle Structures
	
#---------------------------------------

func _build_people_list(struct: Structures) -> void:
	#var struct: Structures = DataManager.get_structure_by_coords(coords)
	#if struct == null:
		#print("NO structure with Coords: " + str(coords))
			
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
			empty_person_label.text = "Free"
		person_list.add_child(personPanel)
	person_list_container.add_child(person_list)

func _update_ui() -> void:
	delete_btn.disabled = _can_object_be_deleted()
	if is_structure:
		remove_person_btn.disabled = _can_remove_be_pressed()
		add_person_btn.disabled = _can_add_be_pressed()
		_build_people_list(structure)

func _on_add_person() -> void:
	#Needs to add a Person to this struct.
	#Get a Person
	pass

func _can_add_be_pressed() -> bool:
	return true

func _on_remove_person() -> void:
	pass

func _can_remove_be_pressed() -> bool:
	return true

func _on_delete_object() -> void:
	pass

func _can_object_be_deleted() -> bool:
	return true
	
	#Get MapObject: Create UI
	#if MapObject is Structure: Create More UI
	#If MapObject is Job or Housing: Create More UI
	#If MapObejct can be deleted add a Button to do so.
