extends Node

var is_running := false
var is_paused := false
var was_paused := false
"""
signal paused
signal unpaused
"""
#Skal indholde tidsstyring. Seasons! Pause, play. 
func game_main():
	is_running = true
	is_paused = false
	was_paused  = false
	run_game_loop()
	pass

func run_game_loop():
	while is_running:
		await get_tree().create_timer(5.0).timeout
		if get_tree().paused:
			await wait_until_unpaused()
		#evt small timeout el lign her for stagger mellem pause og gamefunctions
		await SimulationManager.sim_main()
		#put season/ui stuff here?

func wait_until_unpaused():
	while get_tree().paused:
		await get_tree().process_frame
"""
func pause_game():
	if get_tree().paused:
		return
	get_tree().paused = true
	paused.emit()

func unpause_game():
	if not get_tree().paused:
		return
	get_tree().paused = false
	unpaused.emit()
"""
