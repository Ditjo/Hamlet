extends PopupPanel

class_name EventPopup

signal button_pressed(button: String)

@onready var event_title: Label = $VBoxContainer/EventTitle
@onready var description: RichTextLabel = $VBoxContainer/Description
@onready var options_panel: HBoxContainer = $VBoxContainer/OptionsPanel

func _ready() -> void:
	get_window().size_changed.connect(_on_window_resize)
	_cleanup()

func _on_button_pressed(response: String) -> void:
	button_pressed.emit(response)
	close()

func close() -> void:
	self.hide()
	_cleanup()
	
func open(event: Event) -> void:
	_cleanup()
	event_title.text = event.event_name
	description.text = event.description
	for o in event.options:
		var btn = Button.new()
		btn.text = o.btn_text
		btn.pressed.connect(_on_button_pressed.bind(o.response))
		options_panel.add_child(btn)
	
	_on_window_resize()
	self.popup()

func _cleanup() -> void:
	event_title.text = ""
	description.text = ""
	var buttons = options_panel.get_children()
	for btn in buttons:
		btn.queue_free()

func _on_window_resize() -> void:
	_popup_percent(0.6, 0.4)

func _popup_percent(width_pct: float, height_pct: float):
	#var window_size = get_window().get_visible_rect().size
	#
	#var popup_size = Vector2(
		#window_size.x * width_pct,
		#window_size.y * height_pct
	#)
	
	size.x = 600
	size.y = 400
	
	#size.x = get_window().window_size.x * width_pct
	#size.y = get_window().window_size.y * height_pct
	
	#size = popup_size
	
	#position = (get_window().size - popup_size) * 0.5
	
	
	
