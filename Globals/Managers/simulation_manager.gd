extends Node

#Skal indholde simulationen af spillet. Game Loop. 
#Skal subscribe til et signal fra GameManageren som fortæller hvornår at simuleringen skal køre. 

func sim_main() -> void:
	event_func()
	harvest_func()
	production_func()
	sale_func()
	people_func()

func event_func() -> void:
	pass

func harvest_func() -> void:
	pass

func production_func() -> void:
	pass

func sale_func() -> void:
	pass

func people_func() -> void:
	pass
