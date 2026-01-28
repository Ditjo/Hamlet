extends Node

#Skal indholde simulationen af spillet. Game Loop. 
#Skal subscribe til et signal fra GameManageren som fortæller hvornår at simuleringen skal køre. 

func sim_main() -> void:
	var new_event: Event = 	event_func()
	harvest_func(new_event)
	production_func(new_event)
	sale_func(new_event)
	people_func(new_event)

func event_func() -> Event:
	
	return null

func harvest_func(new_event: Event) -> void:
	if new_event != null && new_event.type.EventTypes.HARVEST:
		pass
	else:
		pass
	pass

func production_func(new_event: Event) -> void:
	pass

func sale_func(new_event: Event) -> void:
	pass

func people_func(new_event: Event) -> void:
	pass
