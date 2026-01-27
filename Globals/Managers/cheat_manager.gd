extends Node

signal toggle_left_drawer
signal toggle_right_drawer

func on_left_draw_pressed() -> void:
	toggle_left_drawer.emit()

func on_right_draw_pressed() -> void:
	toggle_right_drawer.emit()
