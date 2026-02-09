extends MapObjects
class_name MapObjectGrasslandWithMushrooms

func _init(
	name_: String = "Grassland with mushrooms",
	description_: String = "Grassland with mushrooms. Are they edible? ",
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
