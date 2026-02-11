extends JobStructures
class_name Field

func _init(
	name_: String = "Field",
	description_: String = "A field can grow grops, that can be sold, to earn gold. The field must be worked by people to generate grops.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 15},
	max_workers_: int = 3,
	currentWorkers_: Array[Person] = [],
	production_per_worker_ = 2,
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.FIELD,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(0,7)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_workers = max_workers_
	self.currentWorkers = currentWorkers_
	self.production_per_worker = production_per_worker_
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
