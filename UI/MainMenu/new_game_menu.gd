extends PanelContainer
class_name NewGameMenu

signal new_game_started()

@onready var town_name_input: LineEdit = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/MarginContainer2/TownNameInput
@onready var start_game_btn: Button = $MarginContainer/VBoxContainer/MarginContainer3/StartGameBtn


func _ready() -> void:
	start_game_btn.pressed.connect(_on_start_game_btn_pressed)
	town_name_input.text_changed.connect(_can_start_game_btn_be_pressed)
	_can_start_game_btn_be_pressed("")
	
func _on_start_game_btn_pressed() -> void:
	DataManager.town_name = town_name_input.text
	new_game_started.emit()
	town_name_input.clear()

func _can_start_game_btn_be_pressed(text: String) -> void:
	start_game_btn.disabled = text.is_empty()
