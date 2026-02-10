extends PopupPanel

class_name EventPopup

signal button_pressed(button: String)

@onready var event_title: Label = $MarginContainer/VBoxContainer/EventTitle
@onready var description: RichTextLabel = $MarginContainer/VBoxContainer/Description
@onready var options_panel: HBoxContainer = $MarginContainer/VBoxContainer/OptionsPanel

var is_visible: bool = false

func _ready() -> void:
	get_tree().root.get_window().size_changed.connect(_on_window_resize)
	popup_hide.connect(popup_is_hiden)
	_cleanup()

#Work Around
func popup_is_hiden() -> void:
	if is_visible:
		is_visible = false
		_cleanup()
		GameManager.unpause_game()
		#print("popup_is_hiden!!!!")

func _on_button_pressed(response: String) -> void:
	button_pressed.emit(response)
	close()

func close() -> void:
	self.hide()
	is_visible = false
	_cleanup()
	
func open(event: Event) -> void:
	_cleanup()
	event_title.text = event.event_name
	description.text = event.description
	for o in event.options:
		#MakeBtn
		var btn = Button.new()
		btn.text = o.btn_text
		btn.custom_minimum_size.x = 100
		btn.pressed.connect(_on_button_pressed.bind(o.response))
		
		#MakeContainer
		var center = CenterContainer.new()
		center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		center.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		
		center.add_child(btn)
		
		options_panel.add_child(center)
	
	_on_window_resize()
	is_visible = true
	self.popup()

func _cleanup() -> void:
	event_title.text = ""
	description.text = ""
	var buttons = options_panel.get_children()
	for btn in buttons:
		btn.queue_free()

func _on_window_resize() -> void:
	
	_popup_percent(0.4, 0.4)
	
	if is_visible:
		call_deferred("popup", size)

func _popup_percent(width_pct: float, height_pct: float):
	var main_window: Window = get_tree().root.get_window()
	var window_size: Vector2i = main_window.size
	
	var popup_size = Vector2(
		window_size.x * width_pct,
		window_size.y * height_pct
	)
	
	size = popup_size
	
	
	
