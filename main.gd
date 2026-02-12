extends Node

#The Startup file
@onready var cheat_menu: CanvasLayer = $CheatMenu

func s() -> void:
	pass

func _ready():
	cheat_menu.visible = false
	GameManager.game_main()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cheat_menu"):
		cheat_menu.visible = !cheat_menu.visible
