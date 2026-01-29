class_name MapObjects

extends Resource

var object_name: String
var description: String
var map_object_type: Enums.MapObjectTypes
var coords: Vector2i
var cost: Dictionary = {}

func _init(
	name_: String = "",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	coords = coords_
	cost = cost_

func _resolve_assets() -> void:
	pass
	
func can_delete_object() -> bool:
	return true
	
func can_build_object() -> bool:
	return true
