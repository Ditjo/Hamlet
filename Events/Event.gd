@abstract class_name Event

extends Resource

var event_name: String
var description: String
var type: Enums.EventTypes
var options: Array[Option] = []

func _resolve_assets() -> void:
	pass

func can_event_trigger() -> bool:
	return true

func trigger_event(response: String) -> Array:
	return []

func event_response(response: Enums) -> void:
	pass
