extends PanelContainer

@onready var gold_info: BasicInfoPanel = $HBoxContainer/GoldInfo
@onready var people_info: BasicInfoPanel = $HBoxContainer/PeopleInfo
@onready var housing_info: BasicInfoPanel = $HBoxContainer/HousingInfo
@onready var workers_info: BasicInfoPanel = $HBoxContainer/WorkersInfo
@onready var jobs_info: BasicInfoPanel = $HBoxContainer/JobsInfo


func _ready() -> void:
	DataManager.gold_changed.connect(_set_gold)
	DataManager.population_changed.connect(_set_people)
	DataManager.max_housing_changed.connect(_set_max_housing)
	DataManager.working_population_changed.connect(_set_current_workers)
	DataManager.available_jobs_changed.connect(_set_available_jobs)

func _set_gold(amount: int) -> void:
	gold_info.set_amount(amount)
	
func _set_people(amount: int) -> void:
	people_info.set_amount(amount)

func _set_max_housing(amount: int) -> void:
	housing_info.set_amount(amount)

func _set_current_workers(amount: int) -> void:
	workers_info.set_amount(amount)

func _set_available_jobs(amount: int) -> void:
	jobs_info.set_amount(amount)
