extends JobStructures
class_name Field

func _init(
	name_: String = "Field",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 15},
	max_workers_: int = 3,
	currentWorkers_: Array[Person] = [],
	production_per_worker_ = 2,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(0,7)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_workers = max_workers_
	self.currentWorkers = currentWorkers_
	self.production_per_worker = production_per_worker_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
