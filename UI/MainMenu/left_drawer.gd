extends PanelContainer

@onready var drawer := self
var is_open: bool = true
@export var animation_time: float = 0.25
@export_range(0.0, 0.5, 0.05, "How far left draw slides out in %")
var drawer_width_ratio: float = 0.25

func _ready() -> void:
	CheatManager.toggle_left_drawer.connect(toggle)
	get_window().size_changed.connect(_on_window_resized)
	_on_window_resized()

func get_drawer_width() -> float:
	return get_window().size.x * drawer_width_ratio

func _on_window_resized() -> void:
	drawer.size.x = get_drawer_width()
	if is_open:
		drawer.position.x = 0
	else:
		drawer.position.x = -drawer.size.x

func toggle(): 
	var tween: Tween = create_tween()
	var width: float = 0
	
	is_open = !is_open
	if is_open:
		#Open Drawer
		width = 0.0
	else:
		#Close Drawer
		width = -drawer.size.x
	
	tween.tween_property(drawer, "position:x", width, animation_time)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)
