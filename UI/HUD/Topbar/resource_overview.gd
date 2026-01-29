extends PanelContainer

@onready var gold_info: BasicInfoPanel = $HBoxContainer/GoldInfo
@onready var people_info: BasicInfoPanel = $HBoxContainer/PeopleInfo


func _ready() -> void:
	DataManager.gold_changed.connect(_set_gold)
	DataManager.population_changed.connect(_set_people)

func _set_gold(amount: int) -> void:
	gold_info.set_amount(amount)
	
func _set_people(amount: int) -> void:
	people_info.set_amount(amount)
