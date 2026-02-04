extends Control
class_name TileInfoPanel

@onready var title: Label = $VBox/Title

func set_info_panel(text: String) -> void:
	title.text = text
