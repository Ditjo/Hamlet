extends Event

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Good Sale",
	desc_: String = "",
	type_: Enums.EventTypes = Enums.EventTypes.SALE,
	opts_: Array[Option] = [Option.new("Ok", "Ok")]
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
	var money_makers:= [Enums.StructureTypes.FIELD]#add all building types that earn money
	for struct_type in money_makers:
		if DataManager.get_structures_by_type(struct_type).size() > 0:
			return true
	return false

func trigger_event(optional = null) -> Array:
	#do "await" visual box w/ ok btn
	#potentially move harvest factor up to include in message?
	#do functionality
	var harvest_factor: float = snapped(rng.randf_range(1.2,1.4),0.01)
	return [0, harvest_factor]#0 affects everything
