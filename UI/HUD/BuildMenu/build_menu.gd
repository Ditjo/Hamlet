extends PanelContainer
class_name Buildmenu

signal building_selected(type: Enums.StructureTypes)

#@onready var info_popup: BuildInfoPopup = BuildInfoPopup.new()
@onready var build_info_popup: BuildInfoPopup = $BuildInfoPopup
@onready var hover_timer: Timer = Timer.new()

var hovered_button: Button
var hovered_structure: Structures
var is_hovering_popup: bool = false

func _ready() -> void:
	hover_timer.one_shot = true
	hover_timer.wait_time = 0.4 #seconds
	hover_timer.timeout.connect(_show_build_info_popup)
	add_child(hover_timer)
	
	build_info_popup.mouse_entered.connect(_on_mouse_entered_popup)
	build_info_popup.mouse_exited.connect(_on_mouse_exited_popup)
	
	add_child(build_info_popup) #<----------------
	_populate_build_menu()
	
func _on_btn_pressed(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)

func _populate_build_menu() -> void:
	var buildcontainer: HBoxContainer = HBoxContainer.new()
	for s in StructureRegistry.structures:
		var btn: Button = Button.new()
		btn.text = s.object_name
		btn.pressed.connect(_on_btn_pressed.bind(s.structure_type))
		btn.mouse_entered.connect(_on_button_hovered.bind(btn, s))
		btn.mouse_exited.connect(_on_button_unhovered)
		
		buildcontainer.add_child(btn)
	self.add_child(buildcontainer)

func _on_button_hovered(btn: Button, structure: Structures) -> void:
	hovered_button = btn
	hovered_structure = structure
	hover_timer.start()

func _on_button_unhovered() -> void:
	hover_timer.stop()
	
	await  get_tree().process_frame
	
	if not is_hovering_popup:
		build_info_popup.hide()

func _show_build_info_popup() -> void:
	if not hovered_button:
		return
	
	build_info_popup.set_data(hovered_structure)
	build_info_popup.reset_size()
	
	var btn_rect: Rect2 = hovered_button.get_rect()
	var btn_pos = hovered_button.position
	
	#var popup_parent = build_info_popup.get_parent()
	#var btn_local_pos = popup_parent.get_global_transform().affine_inverse() * btn_rect.position
	
	print("Button local position: ", btn_pos)
	print("Button rect position: ", btn_rect.position)
	print("Button size: ", btn_rect.size)
	
	var popup_pos: Vector2 = Vector2(
		btn_pos.x + btn_rect.size.x / 2 - build_info_popup.size.x / 2,
		btn_pos.y - build_info_popup.size.y
	)
	
	print("Popup position: ", popup_pos)
	
	#var popup_pos: Vector2 = Vector2(
		#btn_rect.position.x + btn_rect.size.x / 2 - build_info_popup.size.x / 2,
		#btn_rect.position.y - btn_rect.size.y
	#)
	#
	#print("Button local Y: ", btn_local_pos.y)
	#print("Popup Y position: ", popup_pos.y)
	
	#var popup_global_rect = Rect2(
		#build_info_popup.get_parent().get_global_transform() * popup_pos,
		#build_info_popup.size
	#)
	
	var popup_global_rect = Rect2(
		build_info_popup.get_parent().get_global_transform() * popup_pos,
		build_info_popup.size
	)
	
	var viewport_rect = get_viewport_rect()
	
	if popup_global_rect.position.y < 0:
		popup_pos.y = btn_pos.y + btn_rect.size.y
	
	if popup_global_rect.position.x < 0:
		popup_pos.x -= popup_global_rect.position.x
	elif popup_global_rect.end.x > viewport_rect.size.x:
		popup_pos.x -= (popup_global_rect.end.x - viewport_rect.size.x)
	
	build_info_popup.position = popup_pos
	build_info_popup.show()

func _on_mouse_entered_popup() -> void:
	is_hovering_popup = true
	
func _on_mouse_exited_popup() -> void:
	is_hovering_popup = false
	build_info_popup.hide()

#func _hide_build_info_popup() -> void:
	#build_info_popup.hide()
