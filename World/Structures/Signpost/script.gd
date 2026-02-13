extends Structures
class_name Signpost

func _init(
	name_: String = "Signpost",
	description_: String = "Signpost to guide people to nowhere and everywhere. No use in game, though look nice.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.EYECANDY,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 10},
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.SIGNPOST,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(30,26)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
