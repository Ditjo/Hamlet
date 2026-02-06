extends PanelContainer
class_name Buildmenu

@onready var house_btn: Button = $HScrollBar/HBoxContainer/HouseBtn
@onready var field_btn: Button = $HScrollBar/HBoxContainer/FieldBtn
@onready var windmill_btn: Button = $HScrollBar/HBoxContainer/WindmillBtn

signal building_selected(type: Enums.StructureTypes)

func _ready() -> void:
	house_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.HOUSE))
	field_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.FIELD))
	windmill_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.WINDMILL))
	
func _on_btn_pressed(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)
