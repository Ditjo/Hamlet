extends Control
class_name PersonInfoLabel

func set_person(person: Person) -> void:
	var person_name: Label = $PanelContainer/HBoxContainer/PersonName
	var person_age: Label = $PanelContainer/HBoxContainer/PersonAge
	
	
	person_name.text = person.person_name
	person_age.text = "Age: %d" % person.age
