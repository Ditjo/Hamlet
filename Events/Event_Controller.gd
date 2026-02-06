extends Node

signal response

@onready var event_pop_up: EventPopup = %EventPopUp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func call_event(event_: Event):
	event_pop_up.button_pressed.connect(event_response)
	event_pop_up.open(event_)

func event_response(resp: String):
	response.emit()
	event_pop_up.close()
