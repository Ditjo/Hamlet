extends MapObjects
class_name MapObjectRocks

func _init(
	name_: String = "Rocks",
	description_: String = "Rocks are in the way. They can however be move.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.ROCKS,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 20}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

#func can_delete_object() -> bool:
	#return false

func can_build_object() -> bool:
	return false
