extends Event

func _init(
	name_: String = "Bandit Raid",
	desc_: String = "Bandits have attacked your village, some of your villagers have died",
	type_: Enums.EventTypes = Enums.EventTypes.POPULATION,
	opts_: Array[Option] = [Option.new("OK", "Ok")]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	if !DataManager.check_event_flag("Lord_Taxing") and DataManager.get_current_population() > 20:
		return true
	return false

func trigger_event(option: String) -> Array:
	var ppl_factor: int = randi_range(2,6)
	return [1, ppl_factor]
