extends PanelContainer

@onready var season_count: BasicInfoPanel = $HBoxContainer/SeasonCount
@onready var pause_play_btn: Button = $HBoxContainer/HBoxContainer/PausePlayBtn

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	DataManager.seasons_changed.connect(_set_seasons)
	pause_play_btn.pressed.connect(_pause_player_action)
	GameManager.is_paused_changed.connect(_set_pause_visual)

func _set_seasons(value: int) -> void:
	season_count.set_amount(value)

func _pause_player_action() -> void:
	if !GameManager.is_paused:
		GameManager.pause_game()
	else:
		GameManager.unpause_game()
	_set_pause_visual()

func _set_pause_visual() -> void:
	if GameManager.is_paused:
		pause_play_btn.text = "II"
		pause_play_btn.tooltip_text = "The Game is Paused"
	else:
		pause_play_btn.text = ">"
		pause_play_btn.tooltip_text = "The Game is Playing"
