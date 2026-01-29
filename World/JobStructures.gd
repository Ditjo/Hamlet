@abstract class_name JobStructures

extends Structures

var max_workers: int
var currentWorkers: Array = []
var production_per_worker: int


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
