extends PopupPanel
class_name BuildInfoPopup


@onready var object_name_label: Label = $MarginContainer/VBoxContainer/ObjectNameLabel
@onready var description_label: Label = $MarginContainer/VBoxContainer/DescriptionLabel
@onready var cost_label: Label = $MarginContainer/VBoxContainer/CostLabel
@onready var people_label: Label = $MarginContainer/VBoxContainer/PeopleLabel

func setup(structure: Structures) -> void:
	object_name_label.text = structure.object_name
	description_label.text = structure.description
	cost_label.text = "Cost: %d Gold" % structure.cost.get(Enums.CostTypes.GOLD)
	
	if structure is JobStructures:
		people_label.text = "%d Jobs" % structure.max_workers
	elif structure is HousingStructures:
		people_label.text = "+%d Housing" % structure.max_people
	
