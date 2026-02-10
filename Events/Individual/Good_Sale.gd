extends Event

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Good Sale",
	desc_: String = "",
	type_: Enums.EventTypes = Enums.EventTypes.SALE,
	opts_: Array[Option] = [Option.new("OK", "Ok")]
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

func trigger_event(option: String) -> Array:
	var rng = RandomNumberGenerator.new()
	var sale_factor: float = snapped(rng.randf_range(1.15,1.35),0.01)
	return [1, sale_factor]
