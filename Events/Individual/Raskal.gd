extends Event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(
	name_: String = "An odd thing...",
	desc_: String = """People have been talking in the hamlet of wierd things happening in the late hours. It is said that a "Raskal" have been seen rummaging through trash, and whatever is left outside. When people try to get near, it quickly disapper into the woods. No harm done, but a bit unsetteling.""",
	type_: Enums.EventTypes = Enums.EventTypes.EVENT,
	opts_: Array[Option] = [
		Option.new("Weird, but ok", "OK")
	]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	return true


func trigger_event(option: String) -> Array:
	return []
