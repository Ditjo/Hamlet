extends MapObjects
class_name MapObjectTrees

func _init(
	name_: String = "Tree",
	description_: String = "One or more trees.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.TREES,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 8}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

func can_build_object() -> bool:
	return false
