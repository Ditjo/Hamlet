extends MapObjects
class_name MapObjectRiver

func _init(
	name_: String = "River",
	description_: String = "A flowing river. Nice to look at, but can't be removed",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.WATER,
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
