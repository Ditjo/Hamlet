extends Node

var is_running := false
var is_paused := false
var was_paused := false
"""
signal paused
signal unpaused
"""
#Skal indholde tidsstyring. Seasons! Pause, play. 
"""
func _init():
	game_main()
"""
func game_main():
	is_running = true
	is_paused = false
	was_paused = false
	run_game_loop()
	pass

func run_game_loop():
	while is_running:
		await logical_waiter(5.0)
		#if get_tree().paused:
			#await wait_until_unpaused()
		#evt small timeout el lign her for stagger mellem pause og gamefunctions
		print("running")
		#await SimulationManager.sim_main()
		#put season/ui stuff here?

func logical_waiter(sec: float, buffer: float = 0.5):
	var remaining := sec
	while remaining > 0.0:
		await get_tree().process_frame
		if is_paused:
			continue
		if was_paused:
			remaining = max(remaining, buffer)
			was_paused = false
		remaining -= get_process_delta_time()

#func wait_until_unpaused():
	#while get_tree().paused:
		#await get_tree().process_frame

func pause_game():
	if is_paused:
		return
	#get_tree().paused = true
	#paused.emit()
	print("paused")
	is_paused = true
	was_paused = true

func unpause_game():
	if not is_paused:
		return
	#get_tree().paused = false
	#unpaused.emit()
	print("unpaused")
	is_paused = false
