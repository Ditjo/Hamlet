extends Node

signal gold_changed(value: int)
signal population_changed(value: int)
signal seasons_changed(value: int)

var town_name: String
var _gold: int
var _seasons: int
var _map_objects: Dictionary = {}
var _structures: Dictionary = {}
var _population: Array[Person] = []
var _event_flags: Dictionary = {}

#region Gold
func add_gold(gold: int) -> bool:
	_gold += gold
	_on_gold_changed(_gold)
	return true

func remove_gold(gold: int) -> bool:
	_gold -= gold
	_on_gold_changed(_gold)
	return true
	
func get_gold() -> int:
	return _gold

func _on_gold_changed(amount: int) -> void:
	gold_changed.emit(amount)

#endregion

#region Seasons
func increase_seasons() -> void:
	_seasons += 1
	_on_seasons_changed(_seasons)

func _on_seasons_changed(value: int) -> void:
	seasons_changed.emit(value)

#endregion

#region Population
func add_person_to_population(p: Person) -> void:
	_population.append(p)
	_on_population_changed()
	
func remove_person(p: Person) -> void:
	_population.erase(p)
	_on_population_changed()

func get_current_population() -> int:
	return _population.size()

func _on_population_changed() -> void:
	population_changed.emit(_population.size())

#endregion

#When a MapObject or Building is added/deleted it needs to emit a signal telling what and where it was. 
#The TileMapLayer script will then sub to that and add/delete it.
