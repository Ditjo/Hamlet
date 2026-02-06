extends JobStructures
class_name Windmill

func _init(
	name_: String = "Windmill",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 30},
	max_workers_: int = 2,
	currentWorkers_: Array[Person] = [],
	production_per_worker_ = 3
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_workers = max_workers_
	self.currentWorkers = currentWorkers_
	self.production_per_worker = production_per_worker_
