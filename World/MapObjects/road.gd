extends MapObjects
class_name MapObjectRoad

func _init(
	name_: String = "Road",
	description_: String = "A Road. All Roads lead to Rome. Though it is a long way",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.ROAD,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 4}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

func can_delete_object() -> bool:
	return false

func can_build_object() -> bool:
	return false
