extends CanvasLayer

@onready var left_draw_btn: Button = $PanelContainer/LeftDrawBtn
@onready var right_draw_btn: Button = $PanelContainer/RightDrawBtn

#signal toggle_left_drawer
#signal toggle_right_drawer

func _ready() -> void:
	left_draw_btn.pressed.connect(_on_left_draw_pressed)
	right_draw_btn.pressed.connect(_on_right_draw_pressed)

func _on_left_draw_pressed() -> void:
	CheatManager.on_left_draw_pressed()

func _on_right_draw_pressed() -> void:
	CheatManager.on_right_draw_pressed()
