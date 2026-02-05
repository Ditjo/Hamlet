extends Node

#Skal indholde simulationen af spillet. Game Loop. 
#Skal subscribe til et signal fra GameManageren som fortæller hvornår at simuleringen skal køre. 
var rng = RandomNumberGenerator.new()
var event_chance: int = 7
var pop_growth_chance: int = 7

func sim_main() -> void:
	var new_event: Event = event_func()
	var harvests = harvest_func(new_event)
	var production = production_func(new_event, harvests)
	sale_func(new_event, production)
	people_func(new_event)

#region events
func event_func() -> Event:
	if rng.randi_range(1,100) < event_chance:
		#create list of valid events
		var valid_events: Array = []
		var events: Array = [] #get all events here, or get global?
		"""
		some way to get all events
		"""
		for event in events:
			if event.can_event_trigger():
				valid_events.append(event)
		event_chance = 7
		var chosen_event = valid_events.pick_random()
		if chosen_event.type == Enums.EventTypes.EVENT:
			"""do event stuff"""
			return null
		else:
			return chosen_event
	else:
		event_chance += 2
		return null
#endregion

#region harvest
func harvest_func(new_event: Event) -> Dictionary:
	var grain: int = 0
	var event_factor:= []
	if new_event != null && new_event.type == Enums.EventTypes.HARVEST:
		event_factor = new_event.trigger_event() 
	var grain_structs = DataManager.get_structures_by_type(Enums.StructureTypes.FIELD)
	for struct in grain_structs:
		grain += int(struct.production_per_worker * struct.get_current_worker_count() * (event_factor[1] if event_factor[0] in [0,1] else 1))
	#can be inline in foreach if single-use
	#maybe pass array of types? 
	return {
		"grain": grain
	}
#endregion

#region production
func production_func(new_event: Event, harvest: Dictionary) -> Dictionary:
	var grain = harvest["grain"]
	#var limiter: int = ???
	var flour: int = 0
	var event_factor:= []
	if new_event != null && new_event.type == Enums.EventTypes.PRODUCTION:
		event_factor = new_event.trigger_event() 
	var flour_structs = DataManager.get_structures_by_type(Enums.StructureTypes.WINDMILL)
	for struct in flour_structs:
		var work_power = int(struct.production_per_worker * struct.get_current_worker_count() * (event_factor[1] if event_factor[0] in [0,1] else 1))
		var output = min(work_power, grain)
		grain -= output
		flour += output
	return {
		"grain": grain,
		"flour": flour
	}
#endregion

#region sale
func sale_func(new_event: Event, production: Dictionary) -> void:
	var local_gold: int = 0
	var event_factor:= []
	if new_event != null && new_event.type == Enums.EventTypes.SALE:
		event_factor = new_event.trigger_event() 
	local_gold += int(production["grian"] * 2 * (event_factor[1] if event_factor[0] in [0,1] else 1))
	local_gold += int(production["flour"] * 3 * (event_factor[1] if event_factor[0] in [0,2] else 1))
	DataManager.add_gold(local_gold)
#endregion

#region peaple
func people_func(new_event: Event) -> void:
	var population_overview := {
		"max_population" = DataManager.get_max_housing(),
		"current_population" = DataManager.get_current_population(), #get_population -> size
		"housed_population" = DataManager.get_current_housing()
	}
	##assume events have already been vetted for availability
	var event_factor:= []
	if new_event != null && new_event.type == Enums.EventTypes.POPULATION:
		event_factor = new_event.trigger_event() 
		"""
		if event => reduce population, trigger effect here maybe?
		if old_current > new: flag to prevent new ppl?
		"""
		pass
	if population_overview["current_population"] > population_overview["housed_population"]:
		var homeless: Array = DataManager.get_homeless_list()
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
	elif population_overview["current_population"] < population_overview["max_population"]:
		#&& new_event.can_event_trigger(
		if rng.randi_range(1,100) <= pop_growth_chance:
			var available_housing = population_overview["max_population"] - population_overview["current_population"]
			var new_people_count = min(available_housing, rng.randi_range(1,4) + event_factor[1])
			for n in new_people_count:
				var new_person = Person.new()
				new_person.generate_person()
				DataManager.add_person_to_population(new_person)
				"""add person to house"""
			pop_growth_chance = 7
		else:
			pop_growth_chance += 2
#endregion
