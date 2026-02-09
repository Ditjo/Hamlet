extends Event
class_name BadHarvest

func _init(
	name_: String = "Bad Harvest",
	desc_: String = "It's been a bad year for the Harvest.",
	type_: Enums.EventTypes = Enums.EventTypes.HARVEST,
	opts_: Array[Option] = [
		Option.new("Sad, but nothing we can do", "sad"),
		Option.new("Okay, but nothing we can do", "ok")
	]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	#If player has any fields this event can happen
	return DataManager.get_structures_by_type(Enums.StructureTypes.FIELD).size() > 0


func trigger_event(option: String) -> Array:
	var rng = RandomNumberGenerator.new()
	
	if option == "sad":
		#First Option
		print("Bad Harvets: First Option")
		var harvest_factor: float = snapped(rng.randf_range(1.1,1.4),0.01)
		return [1, harvest_factor]
	elif option == "ok":
		#Second Option
		print("Bad Harvets: Second Option")
		var harvest_factor: float = snapped(rng.randf_range(1.1,1.4),0.01)
		return [1, harvest_factor]
	else:
		#Something else happened
		print("Bad Harvets: Something else happened")
		return []
