extends Structures
class_name Statue

func _init(
	name_: String = "Statue",
	description_: String = "A Statue. What is it's story? Only the people know. No use in game, though look nice.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.EYECANDY,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 25},
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.STATUE,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(31,26)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
