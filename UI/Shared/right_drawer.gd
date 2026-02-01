extends PanelContainer
class_name RightDrawer

@onready var drawer := self
var is_open: bool = false
@export var animation_time: float = 0.25
@export_range(0.0, 0.5, 0.05, "How far left draw slides out in %")
var drawer_width_ratio: float = 0.25

func _ready() -> void:
	self.anchor_left = 1
	self.anchor_top = 0
	self.anchor_right = 1
	self.anchor_bottom = 1
	
	get_window().size_changed.connect(_on_window_resized)
	_on_window_resized()

#region DrawerControl
func get_drawer_width() -> float:
	return get_window().size.x * drawer_width_ratio

func _on_window_resized() -> void:
	drawer.size.x = get_drawer_width()
	if is_open:
		drawer.position.x = get_window().size.x - get_drawer_width()
	else:
		drawer.position.x = get_window().size.x

func close()-> void:
	if is_open:
		is_open = false
		var width: float = get_window().size.x
		_move_drawer(width)

func toggle() -> void: 
	var width: float = 0
	
	is_open = !is_open
	if is_open:
		#Open Drawer
		width = get_window().size.x - get_drawer_width()
	else:
		#Close Drawer
		width = get_window().size.x
	
	_move_drawer(width)
	
func _move_drawer(width: float) -> void:
	var tween: Tween = create_tween()
	
	tween.tween_property(drawer, "position:x", width, animation_time)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)
#endregion
