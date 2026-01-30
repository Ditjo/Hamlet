@abstract class_name HousingStructures

extends Structures

var max_people: int
var _people: Array[Person]

func add_person_to_house(p: Person) -> void:
	_people.append(p)
	
func remove_person(p: Person) -> void:
	_people.erase(p)
	
func get_current_house_population() -> int:
	return _people.size()

func is_there_more_room() -> bool:
	return _people.size() < max_people
	#Is this needed?
