extends PopupPanel
class_name BuildInfoPopup

@onready var object_name_label: Label = %ObjectNameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var cost_label: Label = %CostLabel

#signal mouse_entered_popup
#signal mouse_exited_popup

func _ready() -> void:
	set_flag(Window.FLAG_POPUP, false)
	#mouse_entered_popup.connect(_on_mouse_entered_popup)
	#mouse_exited_popup.connect(_on_mouse_exited_popup)

func setup(structure: Structures) -> void:
	object_name_label.text = structure.object_name
	description_label.text = structure.description
	cost_label.text = "Cost: %d Gold" % structure.cost.get(Enums.CostTypes.GOLD)

#func _on_mouse_entered_popup() -> void:
	#mouse_entered_popup.emit()
#
#func _on_mouse_exited_popup() -> void:
	#mouse_exited_popup.emit()
