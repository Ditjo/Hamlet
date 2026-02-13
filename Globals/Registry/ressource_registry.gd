extends Node

##Script of all structures
@export var structure_scripts: Array[Script]
@export var event_scripts: Array[Script]

var structures: Array[Structures] = []
var events: Array[Event] = []

func _ready() -> void:
	#Load Structures
	for script in structure_scripts:
		var instance = script.new()
		if instance is Structures:
			structures.append(instance)
	#Load Events
	for script in event_scripts:
		var instance = script.new()
		if instance is Event:
			events.append(instance)
