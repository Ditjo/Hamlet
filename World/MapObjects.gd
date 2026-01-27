class_name MapObjects

extends Node

var object_name: String
var description: String
var map_object_type: Enums
var coords: Vector2
var cost: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _resolve_assets() -> void:
	pass
	
func can_delete_object() -> bool:
	return true
	
func can_build_object() -> bool:
	return true
