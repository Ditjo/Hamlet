extends Structures
class_name ParkTree

func _init(
	name_: String = "Park Tree",
	description_: String = "A nice planet tree. Like they didn't have enough trees already. No use in game, though look nice.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 20},
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.PARKTREE,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(26,29)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
