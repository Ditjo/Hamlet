extends PanelContainer

@onready var drawer := self
var is_open: bool = false
var drawer_width: int = 300

func _ready() -> void:
	CheatManager.toggle_right_drawer.connect(toggle)
	position.x = get_viewport_rect().size.x

func toggle(): 
	var tween: Tween = create_tween()
	is_open = !is_open
	
	if is_open:
		tween.tween_property(drawer, "position:x", get_viewport_rect().size.x - drawer_width, 0.25)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(drawer, "position:x", get_viewport_rect().size.x, 0.25)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
