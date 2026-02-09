extends Event

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Good Harvest",
	desc_: String = "",
	type_: Enums.EventTypes = Enums.EventTypes.HARVEST,
	opts_: Array[Option] = [Option.new("Fantastic", "Good")]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

"""
func _resolve_assets() -> void:
	pass
"""

func can_event_trigger() -> bool:
	print("can harvest trigger?")
	return true
	return DataManager.get_structures_by_type(Enums.StructureTypes.FIELD).size() > 0
		#return true
	#else:
		#return false

func trigger_event(response: String) -> Array:
	#do "await" visual box w/ ok btn
	#var temp = await pop.button_pressed
	#potentially move harvest factor up to include in message?
	#do functionality
	var harvest_factor: float = snapped(rng.randf_range(1.1,1.4),0.01)
	return [1, harvest_factor]
