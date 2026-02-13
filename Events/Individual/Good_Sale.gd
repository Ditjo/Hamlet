extends Event

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

func can_event_trigger() -> bool:
	var money_makers:= [Enums.StructureTypes.FIELD]#add all building types that earn money
	var money_structs: Array = []
	for struct_type in money_makers:
		money_structs += DataManager.get_structures_by_type(struct_type)
	var workers: int
	for struct in money_structs:
		workers += struct.get_current_worker_count()
	if  money_structs.size() > 0 and workers > 0:
		return true
	else:
		return false

func trigger_event(option: String) -> Array:
	var sale_factor: float = snapped(randf_range(1.15,1.35),0.05)
	return [0, sale_factor]
