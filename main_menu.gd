extends HBoxContainer

@onready var left_drawer: PanelContainer = $LeftDrawer
@onready var right_drawer: PanelContainer = $RightDrawer
@onready var new_game: Button = $LeftDrawer/NewGame

var is_left_open: bool = true
var is_right_open: bool = false

@export var animation_time: float = 0.25

func _ready() -> void:
	new_game.pressed.connect(toggle_right_drawer)
	CheatManager.toggle_left_drawer.connect(toggle_left_drawer)
	
	right_drawer.size_flags_stretch_ratio = 0

func toggle_left_drawer() -> void:
	var tween: Tween = create_tween()
	if is_left_open:
		is_left_open = false
		tween.tween_property(left_drawer, "size_flags_stretch_ratio", 0, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
		
	else:
		is_left_open = true
		tween.tween_property(left_drawer, "size_flags_stretch_ratio", 1, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)


func toggle_right_drawer() -> void:
	var tween: Tween = create_tween()
	if is_right_open:
		is_right_open = false
		tween.tween_property(right_drawer, "size_flags_stretch_ratio", 0, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
		
	else:
		is_right_open = true
		tween.tween_property(right_drawer, "size_flags_stretch_ratio", 1, animation_time)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	
