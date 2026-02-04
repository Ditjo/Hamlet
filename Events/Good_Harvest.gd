extends Event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Good Harvest",
	desc_: String = "",
	type_: Enums.EventTypes = Enums.EventTypes.HARVEST,
	opts_: Array = ["OK"]
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
	if DataManager.get_structures_by_type(Enums.StructureTypes.FIELD).size() > 0:
		return true
	else:
		return false

func trigger_event(optional = null) -> Array[int]:
	#do functionality
	return []
	pass
