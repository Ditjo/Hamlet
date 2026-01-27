extends Node

signal gold_changed(new_amount_gold: int)

var town_name: String
var _gold: int
var _seasons: int
var _map_objects: Dictionary = {}
var _structures: Dictionary = {}
var _population: Array = []
var _event_flags: Dictionary = {}
#var _seasons: int

func add_gold(gold: int) -> bool:
	_gold += gold
	_on_gold_changed(_gold)
	return true

func remove_gold(gold: int) -> bool:
	_gold -= gold
	_on_gold_changed(_gold)
	return true

func _on_gold_changed(amount: int) -> void:
	gold_changed.emit(amount)

func get_gold() -> int:
	return _gold

func increase_seasons() -> void:
	_seasons += 1
	#TODO: update ui or call ui update - signal
	

#When a MapObject or Building is added/deleted it needs to emit a signal telling what and where it was. 
#The TileMapLayer script will then sub to that and add/delete it.
