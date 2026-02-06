extends PanelContainer

@onready var gold_info: BasicInfoPanel = $HBoxContainer/GoldInfo
@onready var people_info: BasicInfoPanel = $HBoxContainer/PeopleInfo
@onready var housing_info: BasicInfoPanel = $HBoxContainer/HousingInfo


func _ready() -> void:
	DataManager.gold_changed.connect(_set_gold)
	DataManager.population_changed.connect(_set_people)
	DataManager.max_housing_changed.connect(_set_max_housing)

func _set_gold(amount: int) -> void:
	gold_info.set_amount(amount)
	
func _set_people(amount: int) -> void:
	people_info.set_amount(amount)

func _set_max_housing(amount: int) -> void:
	housing_info.set_amount(amount)
