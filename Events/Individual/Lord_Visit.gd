extends Event

func _init(
	name_: String = "Visit from the Lord",
	desc_: String = "The local Lord is visiting. He offers protection in return for 5% taxes",
	type_: Enums.EventTypes = Enums.EventTypes.EVENT,
	opts_: Array[Option] = [
		Option.new("Agree", "OK"),
		Option.new("Refuse", "NO")
	]
) -> void:
	event_name = name_
	description = desc_
	type = type_
	options = opts_

func can_event_trigger() -> bool:
	if !DataManager.check_event_flag("Lord_Taxing") and !DataManager.check_event_flag("Lord_Angry") and DataManager.get_gold() > 200:
		return true
	else:
		return false 
		#return true
	#else:
		#return false

func trigger_event(option: String) -> Array:
	if option == "OK":
		#First Option
		return [0, "Lord_Taxing"]
	elif option == "NO":
		#Second Option
		return [0, "Lord_Angry"]
	else:
		#Something else happened
		return []
