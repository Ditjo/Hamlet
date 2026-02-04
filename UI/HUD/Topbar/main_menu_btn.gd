extends PanelContainer

@onready var menu_btn: Button = $MenuBtn
@onready var drawer_main_menu: Drawer = %DrawerMainMenu

func _ready() -> void:
	menu_btn.pressed.connect(_open_main_menu)

func _open_main_menu() -> void:
	drawer_main_menu.toggle()
