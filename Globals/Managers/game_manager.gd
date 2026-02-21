extends Node

signal is_paused_changed()

var is_running := false

var is_paused := true
var was_paused := false

#Skal indholde tidsstyring. Seasons! Pause, play. 
"""
signal paused
signal unpaused

func _init():
	game_main()
"""
func _ready():
	randomize()
	process_mode = Node.PROCESS_MODE_PAUSABLE 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_unpause"):
		if get_viewport().gui_get_focus_owner():
			get_viewport().gui_get_focus_owner().release_focus()
		
		if is_paused:
			unpause_game()
		else:
			pause_game()
		get_viewport().set_input_as_handled()

func game_main():
	is_running = true
	is_paused = false
	was_paused = false
	run_game_loop()
	pass


func run_game_loop():
	while is_running:
		await logical_waiter(7.0)
		#if get_tree().paused:
			#await wait_until_unpaused()
		#evt small timeout el lign her for stagger mellem pause og gamefunctions
		#await get_tree().create_timer(5.0).timeout
		print("running")
		SimulationManager.sim_main()
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
	"""
	if get_tree().paused:
		return
	print("paused")
	get_tree().paused = true
	"""
	if is_paused:
		return
	#get_tree().paused = true
	#paused.emit()
	print("paused")
	is_paused = true
	was_paused = true
	_on_is_paused_changed()
	

func unpause_game():
	"""
	if not get_tree().paused:
		return
	print("unpaused")
	get_tree().paused = false
	"""
	if not is_paused:
		return
	#get_tree().paused = false
	#unpaused.emit()
	print("unpaused")
	is_paused = false
	_on_is_paused_changed()

func _on_is_paused_changed() -> void:
	is_paused_changed.emit()
