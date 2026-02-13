extends Node

var structures: Array[Structures] = []

func _ready() -> void:
	structures = _get_structures()

func _get_structures() -> Array[Structures]:
	#var structures: Array[GDScript] = []
	var _structures: Array[Structures] = []
	
	#Opens the directory on the path and null checks
	var dir: = DirAccess.open("res://world/structures/")
	if dir == null:
		return _structures
	
	#begins to Look into the folder and takes the next/first one
	dir.list_dir_begin()
	var folder: = dir.get_next()
	
	#So long as folder is not empty, loop
	while folder != "":
		if dir.current_is_dir() and not folder.begins_with("."):
			#Opens Subfolder and check if there is anything
			var sub: = DirAccess.open("res://world/structures/%s" % folder)
			if sub:
				sub.list_dir_begin()
				var file: = sub.get_next()
				
				#Runs through subfolders files
				while file != "":
					if file.ends_with(".gd"):
						var script: Resource = load("res://world/structures/%s/%s" % [folder, file])
						if script is GDScript:
							var instance: Structures = script.new()
							
							if instance != null:
								_structures.append(instance)
							else:
								push_warning(
									"%s does not extend Structures" %
									["res://world/structures/%s/%s" % [folder, file]]
								)
							#structs.append(struc)
						#structures.append(load("res://World/Structures/%s/%s" % [folder, file]))
					file = sub.get_next()
		
		folder = dir.get_next()
	dir.list_dir_end()
	
	return	_structures
