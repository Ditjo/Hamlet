extends MapObjects
class_name MapObjectGrasslandWithFlowers

func _init(
	name_: String = "Grassland with flowers",
	description_: String = "Grassland with flowers. Ready to grow crops or build on.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.GRASS,
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
