extends Node
class_name EventController

signal return_response(reponse: Array)

@onready var event_pop_up: EventPopup = %EventPopUp

var event: Event

func _ready():
	SimulationManager.event_controller = self
	event_pop_up.button_pressed.connect(event_response)

func call_event(event_: Event):
	event = event_
	GameManager.pause_game()
	event_pop_up.open(event)

func event_response(option: String):
	var response: Array = event.trigger_event(option)
	GameManager.unpause_game()
	return_response.emit(response)
	
