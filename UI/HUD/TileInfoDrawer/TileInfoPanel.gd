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

func set_info_panel(object: MapObjects, coords: Vector2i = Vector2i(-1,-1)) -> void:
	person_controls.visible = false
	for child in person_list_container.get_children():
		child.queue_free()
	
	title.text = object.object_name
	description.text = object.description
	
	if coords != Vector2i(-1,-1):
		var struct: Structures = DataManager.get_structure_by_coords(coords)
		if struct == null:
			print("NO structure with Coords: " + str(coords))
			
		var people: Array[Person] = []
		var people_count: int = 0
		if object is JobStructures:
			people_info.text = "Workers %d/%d" % [object.get_current_worker_count(), object.max_workers]
			people = object.currentWorkers
			people_count = object.max_workers
			person_controls.visible = true
			pass
		elif object is HousingStructures:
			people_info.text = "Occupants %d/%d" % [object.get_current_house_population(), object.max_people]
			people = object._people
			people_count = object.max_people
			pass
		var person_list: VBoxContainer = VBoxContainer.new()
		person_list.size_flags_vertical = Control.SIZE_EXPAND_FILL
		for p in people_count:
			var personPanel: PanelContainer = PanelContainer.new()
			personPanel.size_flags_vertical = Control.SIZE_EXPAND_FILL
			if people.size() > 0:
				#people[p]
				var person_info_label: PersonInfoLabel = PersonInfoLabel.new()
				person_info_label.set_person(people[p])
				personPanel.add_child(person_info_label)
			else:
				var empty_person_label: Label = Label.new()
				empty_person_label.text = "Free"
				personPanel.add_child(empty_person_label)
				pass
			person_list.add_child(personPanel)
		person_list_container.add_child(person_list)
	
	if object.can_delete_object():
		delete_btn.visible = true
	else:
		delete_btn.visible = false
		#Use this Area to Handle Structures
	
	#Get MapObject: Create UI
	#if MapObject is Structure: Create More UI
	#If MapObject is Job or Housing: Create More UI
	#If MapObejct can be deleted add a Button to do so.
