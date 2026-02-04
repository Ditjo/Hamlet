extends Control

#Drawers
@onready var drawer_main_menu: Drawer = %DrawerMainMenu
@onready var drawer_new_game: Drawer = $DrawerNewGame
@onready var drawer_save_game: Drawer = $DrawerSaveGame
@onready var drawer_load_game: Drawer = $DrawerLoadGame
@onready var drawer_options: Drawer = $DrawerOptions

#Buttons
@onready var new_game_btn: Button = %NewGameBtn
@onready var save_game_btn: Button = %SaveGameBtn
@onready var load_game_btn: Button = %LoadGameBtn
@onready var options_btn: Button = %OptionsBtn
@onready var quit_btn: Button = %QuitBtn


func _ready() -> void:	
	new_game_btn.pressed.connect(_on_new_game_pressed)
	save_game_btn.pressed.connect(_on_save_game_pressed)
	load_game_btn.pressed.connect(_on_load_game_pressed)
	options_btn.pressed.connect(_on_options_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed() -> void:
	drawer_new_game.toggle()
	drawer_save_game.close()
	drawer_load_game.close()
	drawer_options.close()
	
func _on_save_game_pressed() -> void:
	drawer_new_game.close()
	drawer_save_game.toggle()
	drawer_load_game.close()
	drawer_options.close()
	
func _on_load_game_pressed() -> void:
	drawer_new_game.close()
	drawer_save_game.close()
	drawer_load_game.toggle()
	drawer_options.close()
	
func _on_options_pressed() -> void:
	drawer_new_game.close()
	drawer_save_game.close()
	drawer_load_game.close()
	drawer_options.toggle()

func _on_quit_pressed() -> void:
	drawer_main_menu.close()
	drawer_new_game.close()
	drawer_save_game.close()
	drawer_load_game.close()
	drawer_options.close()
