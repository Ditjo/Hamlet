extends MapObjects
class_name MapObjectMountain

func _init(
	name_: String = "Mountain",
	description_: String = "A large Mountain. Not possible to build on.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.MOUNTAINS,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 0}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

func can_delete_object() -> bool:
	return false

func can_build_object() -> bool:
	return false
