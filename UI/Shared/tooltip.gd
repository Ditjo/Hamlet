extends Control
class_name Tooltip

@onready var label: Label = $Label

var lifetime: float = 1.2 #seconds
var timer: float = 0.0

func show_tooltip(text: String, color: Color = Color.WHITE_SMOKE) -> void:
	label.text = text
	label.modulate = color
	timer = lifetime
	visible = true

func _process(delta: float) -> void:
	if not visible:
		return
	
	global_position = get_viewport().get_mouse_position() + Vector2(12, 12)
	
	timer -= delta
	if timer <= 0:
		visible = false
