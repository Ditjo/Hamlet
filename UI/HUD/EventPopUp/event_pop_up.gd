extends PopupPanel

class_name EventPopup

signal button_pressed(button: String)

func _ready() -> void:
	#self.anchor
	
	pass
	
		
func _on_button_pressed(button: String) -> void:
	button_pressed.emit(button)
	close()

func close() -> void:
	self.hide()

func open(event: Event) -> void:
	#event.options
	"foreach option in options"
	"build buttons"
	pass
	self.popup()
	"""
	
	
	
	"""
