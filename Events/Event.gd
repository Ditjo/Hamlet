class_name Event

extends Node

var event_name: String
var description: String
var type: Enums
var options: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _resolve_assets() -> void:
	pass

func can_event_trigger() -> bool:
	return true

func trigger_event(optional = null) -> void:
	pass

func event_response(response: Enums) -> void:
	pass
