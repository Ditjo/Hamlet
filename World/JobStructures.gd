@abstract class_name JobStructures

extends Structures

var max_workers: int
var currentWorkers: Array[Person] = []
var production_per_worker: int

func _init(
	name_: String = "",
	description_: String = "",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {},
	max_workers_: int = 4,
	currentWorkers_: Array[Person] = [],
	production_per_worker_ = 1,
	atlas_source_id_: int = -1,
	atlas_coords: Vector2i = Vector2i.ZERO
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_workers = max_workers_
	self.currentWorkers = currentWorkers_
	self.production_per_worker = production_per_worker_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords

func add_worker(person: Person) -> bool:
	if currentWorkers.size() < max_workers:
		currentWorkers.append(person)
		return true
	else:
		return false

func remove_worker(index: int) -> bool:
	if currentWorkers[index] != null:
		currentWorkers.remove_at(index)
		return true
	else:
		return false

func get_max_workers() -> int:
	return max_workers
	
func get_current_worker_count() -> int:
	return currentWorkers.size()
