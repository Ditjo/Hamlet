extends Node

signal gold_changed(new_amount_gold: int)

var town_name: String
var _gold: int
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


#When a MapObject or Building is added/deleted it needs to emit a signal telling what and where it was. 
#The TileMapLayer script will then sub to that and add/delete it.
