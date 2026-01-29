extends PanelContainer

@onready var season_count: BasicInfoPanel = $HBoxContainer/SeasonCount

func _ready() -> void:
	DataManager.seasons_changed.connect(_set_seasons)

func _set_seasons(value: int) -> void:
	season_count.set_amount(value)
