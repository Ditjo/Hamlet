extends Node

#Skal indholde simulationen af spillet. Game Loop. 
#Skal subscribe til et signal fra GameManageren som fortæller hvornår at simuleringen skal køre. 

func sim_main() -> void:
	var new_event: Event = event_func()
	var harvests = harvest_func(new_event)
	var production = production_func(new_event, harvests)
	sale_func(new_event, production)
	people_func(new_event)

#region events
func event_func() -> Event:
	
	return null
#endregion

#region harvest
func harvest_func(new_event: Event) -> Dictionary:
	var grain: int = 0
	var event_factor:= []
	if new_event != null && new_event.type.EventTypes.HARVEST:
		#event_factor = new_event.event_response("enum") 
		pass
	var grain_structs := [
		Enums.StructureTypes.FIELD
	]
	for struct in DataManager._structures:
		if struct.type in grain_structs:
			grain += struct.production_per_worker * struct.get_current_worker_count() * event_factor[0]
			#can be struct.do_math_for_value
	pass
	return {
		"grain": grain
	}
#endregion

#region production
func production_func(new_event: Event, harvest: Dictionary) -> Dictionary:
	var grain = harvest["grain"]
	var flour: int = 0
	var event_factor:= []
	if new_event != null && new_event.type.EventTypes.PRODUCTION:
		#event_factor = new_event.event_response("enum") 
		pass
	var flour_structs := [
		Enums.StructureTypes.WINDMILL
	]
	#TODO: prevent overdraw of grain
	for struct in DataManager._structures:
		if struct.type in flour_structs:
			flour += struct.production_per_worker * struct.get_current_worker_count() * event_factor[0]
	grain -= flour
	return {
		"grain": grain,
		"flour": flour
	}
#endregion

#region sale
func sale_func(new_event: Event, production: Dictionary) -> void:
	var local_gold: int = 0
	var event_factor:= []
	if new_event != null && new_event.type.EventTypes.SALE:
		#event_factor = new_event.event_response("enum") 
		pass
	local_gold += production["grian"] * 2 * (event_factor[0] if event_factor[1] == 0 else 1)
	local_gold += production["flour"] * 3 * (event_factor[0] if event_factor[1] == 1 else 1)
	DataManager.add_gold(local_gold)
	pass
#endregion

#region peaple
func people_func(new_event: Event) -> void:
	var population_overview := {
		"max_population" = 0,
		"current_population" = DataManager.get_current_population(), #get_population -> size
		"housed_population" = 0
	}
	for struct in DataManager._structures:
		if struct.type == Enums.StructureTypes.HOUSE:
			population_overview["max_population"] += struct.max #fix to actual func/var
			population_overview["housed_population"] += struct.current #fix to actual func/var
	var event_factor:= []
	if new_event != null && new_event.type.EventTypes.POPULATION:
		#event execution based on its variables
		pass
	if population_overview["current_population"] > population_overview["housed_population"]:
		pass #house homeless then maybe any remaining homeless leave
	elif population_overview["current_population"] < population_overview["max_population"]:
		pass #do chance to add new ppl to village etc
	
	pass
#endregion
