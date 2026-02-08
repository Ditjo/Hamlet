class_name MapObjects

extends Resource

var object_name: String
var description: String
var map_object_type: Enums.MapObjectTypes
#var coords: Vector2i
var cost: Dictionary = { Enums.CostTypes.GOLD: 0 }

func _init(
	name_: String = "",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {}
) -> void:
	object_name = name_
	description = description_
	map_object_type = type_
	#coords = coords_
	cost = cost_

func _resolve_assets() -> void:
	pass

#Do you have more gold than it cost to remove it
func can_delete_object() -> bool:
	var c: int = cost.get(Enums.CostTypes.GOLD)
	return DataManager.get_gold() >= (c / 2)
	
#Do you have more gold than it cost to build it
func can_build_object() -> bool:
	var c: int = cost.get(Enums.CostTypes.GOLD)
	return DataManager.get_gold() >= c


#Do you have more gold than it cost to build it
#func can_pay_the_cost() -> bool:
	#var c: int = cost.get(Enums.CostTypes.GOLD)
	#return DataManager.get_gold() > c
