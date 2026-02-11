extends Control
class_name PersonInfoLabel

@onready var person_name: Label = $PanelContainer/HBoxContainer/PersonName
@onready var person_age: Label = $PanelContainer/HBoxContainer/PersonAge


func set_person(person: Person) -> void:
	person_name.text = person.person_name
	person_age.text = "Age: %d" % person.age
