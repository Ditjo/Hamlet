extends Event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "Stormy Weather",
	desc_: String = "The stormy weather can either improve your production or halt it. Do you want to reduce windmill effectiveness to avoid the risk?",
	type_: Enums.EventTypes = Enums.EventTypes.PRODUCTION,
	opts_: Array[Option] = [
		Option.new("Yes", "YES"),
		Option.new("No", "NO")
	]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	var windmills = DataManager.get_structures_by_type(Enums.StructureTypes.WINDMILL)
	var workers: int
	for struct in windmills:
		workers += struct.get_current_worker_count()
	if  windmills.size() > 0 and workers > 0:
		return true
	else:
		return false 
		#return true
	#else:
		#return false

func trigger_event(option: String) -> Array:
	if option == "NO":
		#First Option
		var chance = 40
		if randi_range(1,100) < chance:
			return[0, 0.0]
		var prod_factor: float = snapped(randf_range(1.3,1.65),0.05)
		return [0, prod_factor]
	elif option == "YES":
		#Second Option
		var prod_factor: float = snapped(randf_range(0.55,0.7),0.05)
		return [0, prod_factor]
	else:
		#Something else happened
		return []
