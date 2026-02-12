extends PanelContainer

@onready var menu_btn: Button = $MenuBtn
@onready var main_menu: MainMenu = $"../../../../../UI/MainMenu"


func _ready() -> void:
	menu_btn.pressed.connect(_open_main_menu)

func _open_main_menu() -> void:
	main_menu._on_main_menu_pressed()
