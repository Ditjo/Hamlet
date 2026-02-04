extends PanelContainer

@onready var season_count: BasicInfoPanel = $HBoxContainer/SeasonCount
@onready var pause_play_btn: Button = $HBoxContainer/HBoxContainer/PausePlayBtn

var is_paused: bool = false

func _ready() -> void:
	DataManager.seasons_changed.connect(_set_seasons)
	pause_play_btn.pressed.connect(_pause_player_action)

func _set_seasons(value: int) -> void:
	season_count.set_amount(value)

func _pause_player_action() -> void:
	is_paused = !is_paused
	
	if is_paused:
		pause_play_btn.text = "II"
		pause_play_btn.tooltip_text = "The Game is Paused"
		#Call Method In GameManager to Pause
		GameManager.pause_game()
	else:
		pause_play_btn.text = ">"
		pause_play_btn.tooltip_text = "The Game is Playing"
		#Call Method In GameManager to UnPause
		GameManager.unpause_game()
