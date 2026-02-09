extends MapObjects
class_name MapObjectBush

func _init(
	name_: String = "Bush",
	description_: String = "A bush. Can me easily removed",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.TREES,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 4}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	cost = cost_

#func can_delete_object() -> bool:
	#return false

func can_build_object() -> bool:
	return false
