@abstract class_name HousingStructures

extends Structures

var max_people: int
var _people: Array[Person]

func _init(
	name_: String = "",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {},
	max_people_: int = 4,
	people_: Array[Person] = [],
	atlas_source_id_: int = -1,
	atlas_coords: Vector2i = Vector2i.ZERO
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_people = max_people_
	self._people = people_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords

func add_person_to_house(p: Person) -> void:
	_people.append(p)
	
func remove_person(p: Person) -> void:
	_people.erase(p)
	
func get_current_house_population() -> int:
	return _people.size()

func available_housing() -> int:
	return max_people - _people.size()
	#Is this needed?
