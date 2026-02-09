extends Control
class_name TileInfoPanel

@onready var title: Label = $VBox/Title
@onready var description: Label = $VBox/Description

func set_info_panel(map_object: MapObjects, coords: Vector2i = Vector2i(-1,-1)) -> void:
	title.text = map_object.object_name
	description.text = map_object.description
	
	#Change to !=
	if coords == Vector2i(-1,-1):
		print("Null Coords")
		#Use this Area to Handle Structures
	
	#Get MapObject: Create UI
	#if MapObject is Structure: Create More UI
	#If MapObject is Job or Housing: Create More UI
	#If MapObejct can be deleted add a Button to do so.
