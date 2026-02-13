extends Structures
class_name Well

func _init(
	name_: String = "Well",
	description_: String = "A well to get water from. No use in game, though look nice.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.EYECANDY,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 15},
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.WELL,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(25,29)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
