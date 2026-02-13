extends Event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Bandit Raid",
	desc_: String = "Bandits have attacked your village, they have stolen some of your wares",
	type_: Enums.EventTypes = Enums.EventTypes.SALE,
	opts_: Array[Option] = [Option.new("OK", "Ok")]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	if !DataManager.check_event_flag("Lord_Taxing") and DataManager.get_gold() > 100:
		return true
	return false

func trigger_event(option: String) -> Array:
	var sale_factor: float = snapped(randf_range(0.9,0.8),0.01)
	return [0, sale_factor]
