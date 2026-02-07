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
