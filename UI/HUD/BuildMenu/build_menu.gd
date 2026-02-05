extends PanelContainer
class_name Buildmenu

@onready var house_btn: Button = $HScrollBar/HBoxContainer/HouseBtn
@onready var field_btn: Button = $HScrollBar/HBoxContainer/FieldBtn
@onready var windmill_btn: Button = $HScrollBar/HBoxContainer/WindmillBtn

signal building_selected(type: String)

func _ready() -> void:
	house_btn.pressed.connect(_on_btn_pressed.bind("house"))
	field_btn.pressed.connect(_on_btn_pressed.bind("field"))
	windmill_btn.pressed.connect(_on_btn_pressed.bind("windmill"))
	
func _on_btn_pressed(type: String) -> void:
	building_selected.emit(type)
