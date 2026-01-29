@abstract class_name Event

extends Resource

var event_name: String
var description: String
var type: Enums
var options: Array = []

func _resolve_assets() -> void:
	pass

func can_event_trigger() -> bool:
	return true

func trigger_event(optional = null) -> void:
	pass

func event_response(response: Enums) -> void:
	pass
