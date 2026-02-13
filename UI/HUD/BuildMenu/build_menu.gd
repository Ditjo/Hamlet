extends PanelContainer
class_name Buildmenu

signal building_selected(type: Enums.StructureTypes)

func _ready() -> void:
	_populate_build_menu()
	
func _populate_build_menu() -> void:
	var buildcontainer: HBoxContainer = HBoxContainer.new()
	for s in StructureRegistry.structures:
		var btn: BuildMenuButton = BuildMenuButton.new()
		btn.setup(s)
		btn.building_selected.connect(_on_building_selected)
		btn.custom_minimum_size = Vector2(100, 0)
		
		
		var margin: = MarginContainer.new()
		#margin.size_flags_vertical = Control.SIZE_EXPAND_FILL
		margin.add_theme_constant_override("margin_left", 3)
		margin.add_theme_constant_override("margin_right", 3)
		margin.add_theme_constant_override("margin_top", 30)
		margin.add_theme_constant_override("margin_bottom", 30)
		margin.add_child(btn)
	
		buildcontainer.alignment = BoxContainer.ALIGNMENT_CENTER
		buildcontainer.add_child(margin)
	self.add_child(buildcontainer)

func _on_building_selected(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)
