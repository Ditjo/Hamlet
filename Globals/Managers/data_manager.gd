extends Node

signal gold_changed(value: int)
signal population_changed(value: int)
signal max_housing_changed(value: int)
signal working_population_changed(value: int)
signal available_jobs_changed(value: int)
signal seasons_changed(value: int)

var town_name: String
var _gold: int
var _seasons: int
var _map_objects: Dictionary = {
	#Enums.MapObjectTypes.TREES: Array[MapObjects],
	#Enums.MapObjectTypes.MOUNTAINS: Array[MapObjects]
} #{key=enum: Array=[MapObjects]} 
#Come back to this!
var _structures: Dictionary = {}
var _population: Array[Person] = []
var _event_flags: Dictionary = {}

func _ready() -> void:
	add_gold(100)

#region Gold
func add_gold(gold: int) -> bool:
	_gold += gold
	_on_gold_changed(_gold)
	return true

func remove_gold(gold: int) -> bool:
	_gold -= gold
	_on_gold_changed(_gold)
	return true
	
func get_gold() -> int:
	return _gold

func _on_gold_changed(amount: int) -> void:
	gold_changed.emit(amount)

#endregion

#region Seasons
func increase_seasons() -> void:
	_seasons += 1
	_on_seasons_changed(_seasons)

func _on_seasons_changed(value: int) -> void:
	seasons_changed.emit(value)

#endregion

#region Population
func add_person_to_population(p: Person) -> void:
	_population.append(p)
	_on_population_changed()
	
func remove_person(p: Person) -> void:
	_population.erase(p)
	_on_population_changed()

func get_random_person() -> Person:
	return _population.pick_random()

func get_current_population() -> int:
	return _population.size()
	
func get_jobless_person() -> Person:
	var jobless: Array[Person] = _population.filter(func(p: Person) -> bool:
		return p.job == Vector2i.ZERO
		)
	return jobless.front()
	
func get_homeless_population() -> Array[Person]:
	return _population.filter(func(p: Person) -> bool:
		return p.home == null
		)

func _on_population_changed() -> void:
	population_changed.emit(_population.size())

#endregion

#region Map Objects
func add_map_object(type: Enums.MapObjectTypes, m: MapObjects) -> void:
	var o = _map_objects.get(type)
	#if o != null:
		
#add
#remove
#endregion

#region Structures
func add_structure(coords: Vector2i, s: Structures) -> void:
	if s is JobStructures:
		s.workers_changed.connect(_on_working_population_changed)
	_structures[coords] = s
	_on_max_housing_changed()
	_on_available_jobs_changed()

func remove_structure(coords: Vector2i) -> void:
	_structures.erase(coords)
	_on_max_housing_changed()
	_on_available_jobs_changed()

func get_current_housing() -> int:
	var current_pop: int = 0
	for s in _structures.values():
		if s is HousingStructures:
			current_pop += s._people.size()
	return current_pop

func get_max_housing() -> int:
	var max_pop: int = 0
	for s in _structures.values():
		if s is HousingStructures:
			max_pop += s.max_people
	return max_pop

func get_house_w_space() -> House:
	for struct in _structures.values():
		if struct is HousingStructures:
			if struct.available_housing() >= 1:
				return struct
	return null

func _on_max_housing_changed() -> void:
	max_housing_changed.emit(get_max_housing())

func get_available_jobs() -> int:
	var _total_jobs = 0
	for s in _structures.values():
		if s is JobStructures:
			_total_jobs += s.max_workers
	return _total_jobs

func _on_available_jobs_changed() -> void:
	available_jobs_changed.emit(get_available_jobs())

func get_working_population() -> int:
	var _total_workers = 0
	for s in _structures.values():
		if s is JobStructures:
			_total_workers += s.get_current_worker_count()
	return _total_workers

func _on_working_population_changed() -> void:
	working_population_changed.emit(get_working_population())

func get_structures_by_type(type: Enums.StructureTypes) -> Array:
	return _structures.values().filter(func(s: Structures) -> bool:
		return s.structure_type == type
	)

func get_structure_by_coords(coords: Vector2i) -> Structures:
	return _structures.get(coords)
	
func get_key_by_value(struct: Structures) -> Vector2i:
	return _structures.find_key(struct)

#endregion

#region eventFlags
func add_event_flag(flag_name: String) -> void:
	_event_flags.app[flag_name] = true

func remove_event_flag(flag_name: String) -> void:
	_event_flags.app[flag_name] = false

func get_event_flags() -> Dictionary:
	return _event_flags

func check_event_flag(flag_name: String) -> bool:
	if _event_flags.get(flag_name, false) == true:
		return true
	else:
		return false
#endregion

#region jobs

	
#endregion

#When a MapObject or Building is added/deleted it needs to emit a signal telling what and where it was. 
#The TileMapLayer script will then sub to that and add/delete it.
