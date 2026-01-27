extends PanelContainer

@onready var drawer := self
var is_open: bool = true
var drawer_width: int = 300
@export var animation_time: float = 0.25

func _ready() -> void:
	CheatManager.toggle_left_drawer.connect(toggle)

func toggle(): 
	var tween: Tween = create_tween()
	is_open = !is_open
	
	if is_open:
		tween.tween_property(drawer, "position:x", 0, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(drawer, "position:x", -drawer_width, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
