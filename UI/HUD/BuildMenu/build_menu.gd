extends PanelContainer
class_name Buildmenu

signal building_selected(type: Enums.StructureTypes)

func _ready() -> void:
	_populate_build_menu()
	
func _on_btn_pressed(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)

func _populate_build_menu() -> void:
	var buildcontainer: HBoxContainer = HBoxContainer.new()
	for s in StructureRegistry.structures:
		var btn: Button = Button.new()
		btn.text = s.object_name
		btn.pressed.connect(_on_btn_pressed.bind(s.structure_type))
		buildcontainer.add_child(btn)
	self.add_child(buildcontainer)
	
