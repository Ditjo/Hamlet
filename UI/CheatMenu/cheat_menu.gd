extends CanvasLayer

@onready var left_draw_btn: Button = $PanelContainer/LeftDrawBtn
#@onready var right_draw_btn: Button = $PanelContainer/RightDrawBtn

signal toggle_left_drawer
#signal toggle_right_drawer

func _ready() -> void:
	print("This CanvasLayer path:", get_path())
	print("Button exists:", has_node("PanelContainer/LeftDrawBtn"))
	#left_draw_btn.pressed.connect(_on_left_draw_pressed)

func _on_left_draw_pressed() -> void:
	toggle_left_drawer.emit()
