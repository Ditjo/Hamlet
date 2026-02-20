extends MapObjects
class_name MapObjectBridge

func _init(
	name_: String = "Bridge",
	description_: String = "A Bridge to help crosse they way of water",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.ROAD,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 12}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

func can_delete_object() -> bool:
	return false

func can_build_object() -> bool:
	return false
