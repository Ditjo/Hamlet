extends PanelContainer

@onready var gold_info: BasicInfoPanel = $HBoxContainer/GoldInfo
@onready var people_info: BasicInfoPanel = $HBoxContainer/PeopleInfo
@onready var housing_info: BasicInfoPanel = $HBoxContainer/HousingInfo
@onready var workers_info: BasicInfoPanel = $HBoxContainer/WorkersInfo
@onready var jobs_info: BasicInfoPanel = $HBoxContainer/JobsInfo
@onready var town_name_label: Label = $HBoxContainer/PanelContainer/MarginContainer/TownNameLabel

@onready var new_game_menu: NewGameMenu = %NewGameMenu


func _ready() -> void:
	DataManager.gold_changed.connect(_set_gold)
	DataManager.population_changed.connect(_set_people)
	DataManager.max_housing_changed.connect(_set_max_housing)
	DataManager.working_population_changed.connect(_set_current_workers)
	DataManager.available_jobs_changed.connect(_set_available_jobs)
	new_game_menu.new_game_started.connect(_on_new_game_started)

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

func _on_new_game_started() -> void:
	town_name_label.text = DataManager.town_name
