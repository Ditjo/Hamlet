extends MapObjects
class_name MapObjectLake

func _init(
	name_: String = "Lake",
	description_: String = "A nice quite lake.",
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
