extends Node

var event_controller: EventController
#@onready var event_pop_up = %EventPopUp

#Skal indholde simulationen af spillet. Game Loop. 
#Skal subscribe til et signal fra GameManageren som fortæller hvornår at simuleringen skal køre. 
var rng = RandomNumberGenerator.new()
var event_chance: int = 100#7
var pop_growth_chance: int = 7
var events: Array[Event] = []

func _ready():
	var folder_path = "res://Events/Individual/"  # folder containing your class scripts
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".gd"):
				var script_path = folder_path + "/" + file_name
				var script = load(script_path)
				if script:
					events.append(script.new())
			file_name = dir.get_next()
		dir.list_dir_end()
	print(events.size())

func sim_main() -> void:
	print("sim_main")
	event_func()
	#var new_event: Event = event_func()
	#var harvests = harvest_func(new_event)
	#var production = production_func(new_event, harvests)
	#sale_func(new_event, production)
	#people_func(new_event)

#region events
func event_func() -> void:
	print("event_func")
	var chosen_event: Event = null
	if rng.randi_range(1,100) < event_chance:
		#create list of valid events
		var valid_events: Array = []
		"""
		some way to get all events
		"""
		for event in events:
			if event.can_event_trigger():
				valid_events.append(event)
		print(valid_events.size())
		#event_chance = 7 <------------------------------Set back in again when done testing
		chosen_event = valid_events.pick_random()
		#if chosen_event != null && chosen_event.type == Enums.EventTypes.EVENT:
			#"""do event stuff"""
			#
			#
			#return null
		#else:
			#return chosen_event
	else:
		event_chance += 2
		#return null
	event_event_check(chosen_event)

func event_event_check(new_event: Event):
	if new_event != null && new_event.type == Enums.EventTypes.EVENT:
		event_controller.return_response.connect(event_event_response)
		event_controller.call_event(new_event)
	else:
		harvest_event_check(new_event)

func event_event_response(response: Array = []):
	event_controller.return_response.disconnect(event_event_response)
	#response not used for anything here? -> this is where event-event functionality happens!
	if response[0] == 0:#encoded to add a flag
		for index in response:
			if index is String:
				DataManager.add_event_flag(index)
	if response[0] == 1:#encoded to remove a flag
		for index in response:
			if index is String:
				DataManager.remove_event_flag(index)
	#maybe combine these so the array can be encoded with multi function eg: [0, "name, 1, "othername"]
	harvest_event_check()

#endregion

#region harvest

func harvest_event_check(new_event: Event = null) -> void:
	if new_event != null && new_event.type == Enums.EventTypes.HARVEST:
		event_controller.return_response.connect(harvest_event_response)
		event_controller.call_event(new_event)
	else:
		harvest_func([], new_event)

func harvest_event_response(response: Array = []):
	event_controller.return_response.disconnect(harvest_event_response)
	harvest_func(response)

func harvest_func(event_factor: Array, new_event: Event = null) -> void:
	print("harvest_func")
	var grain: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.HARVEST:
		#event_factor = new_event.trigger_event(event_pop_up) 
		#event_factor = await event_controller.response.connect()
	var grain_structs = DataManager.get_structures_by_type(Enums.StructureTypes.FIELD)
	for struct in grain_structs:
		grain += int(struct.production_per_worker * struct.get_current_worker_count() * event_filter(event_factor, [0,1]))
		#(event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
	#can be inline in foreach if single-use
	#maybe pass array of types? 
	var harvest: Dictionary = {
		"grain": grain
	}
	
	production_event_check(harvest, new_event)
	
	#return {
		#"grain": grain
	#}
	
	#func harvest_func(new_event: Event) -> Dictionary:
	#print("harvest_func")
	#var grain: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.HARVEST:
		#event_factor = new_event.trigger_event(event_pop_up) 
		##event_factor = await event_controller.response.connect()
	#var grain_structs = DataManager.get_structures_by_type(Enums.StructureTypes.FIELD)
	#for struct in grain_structs:
		#grain += int(struct.production_per_worker * struct.get_current_worker_count() * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
	##can be inline in foreach if single-use
	##maybe pass array of types? 
	#return {
		#"grain": grain
	#}
	
#endregion

#region production
var _harvest: Dictionary = {}

func production_event_check(harvest: Dictionary, new_event: Event = null,) -> void:
	if new_event != null && new_event.type == Enums.EventTypes.PRODUCTION:
		event_controller.return_response.connect(production_event_response)
		_harvest = harvest
		event_controller.call_event(new_event)
	else:
		production_func(harvest, [], new_event)

func production_event_response(response: Array = []):
	event_controller.return_response.disconnect(production_event_response)
	production_func(_harvest, response)

func production_func(harvest: Dictionary, event_factor: Array, new_event: Event = null) -> void:
	print("prod_func")
	var grain = harvest["grain"]
	#var limiter: int = ???
	var flour: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.PRODUCTION:
		#event_factor = new_event.trigger_event(event_pop_up) 
	var flour_structs = DataManager.get_structures_by_type(Enums.StructureTypes.WINDMILL)
	for struct in flour_structs:
		var work_power = int(struct.production_per_worker * struct.get_current_worker_count() * event_filter(event_factor, [0,1]))
		#(event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
		var output = min(work_power, grain)
		grain -= output
		flour += output
		
	var produce: Dictionary = {
		"grain": grain,
		"flour": flour
	}
	
	sale_event_check(produce, new_event)
	
	#return {
		#"grain": grain,
		#"flour": flour
	#}
	
	#func production_func(new_event: Event, harvest: Dictionary) -> Dictionary:
	#print("prod_func")
	#var grain = harvest["grain"]
	##var limiter: int = ???
	#var flour: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.PRODUCTION:
		#event_factor = new_event.trigger_event(event_pop_up) 
	#var flour_structs = DataManager.get_structures_by_type(Enums.StructureTypes.WINDMILL)
	#for struct in flour_structs:
		#var work_power = int(struct.production_per_worker * struct.get_current_worker_count() * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
		#var output = min(work_power, grain)
		#grain -= output
		#flour += output
	#return {
		#"grain": grain,
		#"flour": flour
	#}
#endregion

#region sale
var _produce: Dictionary = {}

func sale_event_check(produce: Dictionary, new_event: Event = null,) -> void:
	if new_event != null && new_event.type == Enums.EventTypes.SALE:
		event_controller.return_response.connect(sale_event_response)
		_produce = produce
		event_controller.call_event(new_event)
	else:
		sale_func(produce, [], new_event)

func sale_event_response(response: Array = []):
	event_controller.return_response.disconnect(sale_event_response)
	sale_func(_produce, response)


func sale_func(production: Dictionary, event_factor: Array, new_event: Event = null ) -> void:
	print("sale_func")
	var local_gold: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.SALE:
		#event_factor = new_event.trigger_event(event_pop_up) 
	local_gold += int(production["grain"] * 2 * event_filter(event_factor, [0,1]))
	local_gold += int(production["flour"] * 3 * event_filter(event_factor, [0,2]))
	#local_gold += int(production["grain"] * 2 * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
	#local_gold += int(production["flour"] * 3 * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,2] else 1))
	if DataManager.check_event_flag("Lord_Taxing"):
		local_gold = int(local_gold * 0.95)
	DataManager.add_gold(local_gold)
	
	people_event_check(new_event)
#func sale_func(new_event: Event, production: Dictionary) -> void:
	#print("sale_func")
	#var local_gold: int = 0
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.SALE:
		#event_factor = new_event.trigger_event(event_pop_up) 
	#local_gold += production["grain"] * 2 * event_filter(event_factor, [0,1])
	#local_gold += production["flour"] * 3 * event_filter(event_factor, [0,2])
	##local_gold += int(production["grain"] * 2 * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,1] else 1))
	##local_gold += int(production["flour"] * 3 * (event_factor[1] if event_factor.size() > 1 and event_factor[0] in [0,2] else 1))
	#DataManager.add_gold(local_gold)
	
#endregion

#region peaple
func people_event_check(new_event: Event = null,) -> void:
	if new_event != null && new_event.type == Enums.EventTypes.POPULATION:
		event_controller.return_response.connect(people_event_response)
		event_controller.call_event(new_event)
	else:
		people_func([])

func people_event_response(response: Array = []):
	event_controller.return_response.disconnect(people_event_response)
	people_func(response)

func people_func(event_factor: Array) -> void:
	print("ppl_func")
	var population_overview := {
		"max_population" = DataManager.get_max_housing(),
		"current_population" = DataManager.get_current_population(), #get_population -> size
		"housed_population" = DataManager.get_current_housing()
	}
	##assume events have already been vetted for availability
	#var event_factor:= []
	#if new_event != null && new_event.type == Enums.EventTypes.POPULATION:
		#event_factor = new_event.trigger_event(event_pop_up) 
		#"""
		#if event => reduce population, trigger effect here maybe?
		#if old_current > new: flag to prevent new ppl?
		#"""
		#pass
	var can_add: bool = true
	if event_factor.size() > 1 and event_factor[0] == 1:#event not null + encoded to remove ppl
		can_add = false
		for count in range(event_factor[1]):
			DataManager.remove_person(DataManager.get_random_person())
	if population_overview["current_population"] > population_overview["housed_population"]:
		can_add = false
		var homeless: Array = DataManager.get_homeless_population()
		if population_overview["current_population"] < population_overview["max_population"]:
			var houses: Array = DataManager.get_structures_by_type(Enums.StructureTypes.HOUSE)
			for house in houses:
				var space: int = house.available_space()
				#maybe for i=?, i > min(space;homeless.size())
				while space > 0 && not homeless.is_empty():
					house.add_person(homeless.pop_front())
					space -= 1
				if homeless.is_empty():
					break
		#chance ppl leave if still ppl
		for person in homeless:
			if rng.randi_range(1,100) < min(90,30+10*homeless.size()):
				DataManager.remove_person(person)
				homeless.erase(person)
	if can_add and population_overview["current_population"] < population_overview["max_population"]:
		#&& new_event.can_event_trigger(
		if rng.randi_range(1,100) <= pop_growth_chance:
			var available_housing = population_overview["max_population"] - population_overview["current_population"]
			var new_people_count = min(available_housing, rng.randi_range(1,4) + event_filter(event_factor, [0], 0))
			for n in new_people_count:
				var new_person = Person.new()
				new_person.generate_person()
				DataManager.add_person_to_population(new_person)
				"""add person to house"""
			pop_growth_chance = 7
		else:
			pop_growth_chance += 2
	#upkeep
	DataManager.remove_gold(max(0, min(int(DataManager.get_current_population() / 3), DataManager.get_gold() - 15)))
#endregion

#region math
"""
func math_product(...values) -> int:
	var result = 1
	for v in values:
		result *= v
	return int(result)
"""

func event_filter(encoding: Array, allowed: Array, default: int = 1) -> int:
	return encoding[1] if encoding.size() > 1 and encoding[0] in allowed else default
#endregion
