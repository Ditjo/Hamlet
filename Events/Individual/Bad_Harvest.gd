extends Event
class_name BadHarvest

func _init(
	name_: String = "Bad Harvest",
	desc_: String = "It's been a bad year for the Harvest.",
	type_: Enums.EventTypes = Enums.EventTypes.HARVEST,
	opts_: Array[Option] = [Option.new("OK", "OK")]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	var harvest_types:= [Enums.StructureTypes.FIELD]#add all building types that do harvest
	var harvest_structs: Array = []
	for struct_type in harvest_types:
		harvest_structs += DataManager.get_structures_by_type(struct_type)
	var workers: int
	for struct in harvest_structs:
		workers += struct.get_current_worker_count()
	if  harvest_structs.size() > 0 and workers > 0:
		return true
	else:
		return false

func trigger_event(option: String) -> Array:
	var harvest_factor: float = snapped(randf_range(0.95,0.8),0.05)
	return [1, harvest_factor]
