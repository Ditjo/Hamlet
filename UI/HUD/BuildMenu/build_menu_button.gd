extends Button
class_name BuildMenuButton

signal building_selected(type: Enums.StructureTypes)

@export var popup_distance_to_button: int = 8

var structure: Structures
var info_popup: BuildInfoPopup
var hover_timer: Timer
var is_hovering_popup: bool = false

func _ready():
	#PopUp
	info_popup = preload("res://UI/Shared/BuildInfoPopup.tscn").instantiate()
	add_child(info_popup)
	info_popup.set_flag(Window.FLAG_POPUP, false)
	info_popup.visible = false
	info_popup.mouse_entered.connect(_on_mouse_entered_popup)
	info_popup.mouse_exited.connect(_on_mouse_exited_popup)
	
	#Timer
	hover_timer = Timer.new()
	hover_timer.one_shot = true	
	hover_timer.wait_time = 0.5
	hover_timer.timeout.connect(_show_popup)
	add_child(hover_timer)
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
func setup(structure_: Structures) -> void:
	structure = structure_
	text = structure_.object_name

func _on_pressed() -> void:
	building_selected.emit(structure.structure_type)

func _on_mouse_entered() -> void:
	hover_timer.start()

func _on_mouse_exited() -> void:
	hover_timer.stop()
	await  get_tree().create_timer(0.1).timeout
	
	if not is_hovering_popup:
		info_popup.hide()

func _show_popup() -> void:
	info_popup.setup(structure)
	info_popup.reset_size()
	
	var button_global_pos = global_position
	var popup_pos = Vector2(
		button_global_pos.x + size.x / 2 - info_popup.size.x / 2,
		button_global_pos.y - info_popup.size.y - popup_distance_to_button
	)
	
	info_popup.position = popup_pos
	info_popup.popup()

func _on_mouse_entered_popup() -> void:
	is_hovering_popup = true
	
func _on_mouse_exited_popup() -> void:
	is_hovering_popup  = false
	info_popup.hide()
