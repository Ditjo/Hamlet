extends PanelContainer
class_name Buildmenu

@onready var house_btn: Button = $HBoxContainer/HouseBtn
@onready var field_btn: Button = $HBoxContainer/FieldBtn
@onready var windmill_btn: Button = $HBoxContainer/WindmillBtn

signal building_selected(type: Enums.StructureTypes)

func _ready() -> void:
	house_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.HOUSE))
	field_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.FIELD))
	windmill_btn.pressed.connect(_on_btn_pressed.bind(Enums.StructureTypes.WINDMILL))
	
func _on_btn_pressed(type: Enums.StructureTypes) -> void:
	building_selected.emit(type)

func _get_structures() -> Array[GDScript]:
	var structures: Array[GDScript] = []
	
	#Opens the directory on the path and null checks
	var dir: = DirAccess.open("res://World/Structures/")
	if dir == null:
		return structures
	
	#begins to Look into the folder and takes the next/first one
	dir.list_dir_begin()
	var folder: = dir.get_next()
	
	#So long as folder is not empty, loop
	while folder != "":
		if dir.current_is_dir() and not folder.begins_with("."):
			#Opens Subfolder and check if there is anything
			var sub: = DirAccess.open("res://World/Structures/%s" % folder)
			if sub:
				sub.list_dir_begin()
				var file: = sub.get_next()
				
				#Runs through subfolders files
				while file != "":
					if file.ends_with(".gd"):
						structures.append(load("res://World/Structures/%s/%s" % [folder, file]))
					file = sub.get_next()
		
		folder = dir.get_next()
	
	dir.list_dir_end()
	return	structures
	

func _populate_build_menu() -> void:
	pass
