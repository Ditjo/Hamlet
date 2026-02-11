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
		
		buildcontainer.add_child(btn)
	self.add_child(buildcontainer)

func _on_building_selected(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)
