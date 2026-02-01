extends Control

@onready var right_drawer_new_game: RightDrawer = $RightDrawerNewGame
@onready var right_drawer_save_game: RightDrawer = $RightDrawerSaveGame
@onready var right_drawer_load_game: RightDrawer = $RightDrawerLoadGame
@onready var right_drawer_options: RightDrawer = $RightDrawerOptions


#Buttons
@onready var new_game_btn: Button = %NewGameBtn
@onready var save_game_btn: Button = %SaveGameBtn
@onready var load_game_btn: Button = %LoadGameBtn
@onready var options_btn: Button = %OptionsBtn


func _ready() -> void:	
	new_game_btn.pressed.connect(_on_new_game_pressed)
	save_game_btn.pressed.connect(_on_save_game_pressed)
	load_game_btn.pressed.connect(_on_load_game_pressed)
	options_btn.pressed.connect(_on_options_game_pressed)

func _on_new_game_pressed() -> void:
	right_drawer_new_game.toggle()
	right_drawer_save_game.close()
	right_drawer_load_game.close()
	right_drawer_options.close()
	
func _on_save_game_pressed() -> void:
	right_drawer_new_game.close()
	right_drawer_save_game.toggle()
	right_drawer_load_game.close()
	right_drawer_options.close()
	
func _on_load_game_pressed() -> void:
	right_drawer_new_game.close()
	right_drawer_save_game.close()
	right_drawer_load_game.toggle()
	right_drawer_options.close()
	
func _on_options_game_pressed() -> void:
	right_drawer_new_game.close()
	right_drawer_save_game.close()
	right_drawer_load_game.close()
	right_drawer_options.toggle()
