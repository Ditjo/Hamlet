extends PanelContainer
class_name BasicInfoPanel

@onready var info_label: Label = $InfoPanel/InfoLabel
@onready var info_amount_label: Label = $InfoPanel/InfoAmount

@export var InfoLabel: String

var _info_amount: int

@onready var info_amount: int = 0:
	set(value):
		_info_amount = value
		info_amount_label.text = str(value)

func _ready() -> void:
	info_label.text = InfoLabel
	info_amount = 0

func set_amount(value: int) -> void:
	info_amount = value
