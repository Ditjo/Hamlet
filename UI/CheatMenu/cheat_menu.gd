extends CanvasLayer

@onready var left_draw_btn: Button = $PanelContainer/LeftDrawBtn
@onready var right_draw_btn: Button = $PanelContainer/RightDrawBtn
@onready var add_gold: Button = $PanelContainer/AddGold
@onready var __1_seasons: Button = $"PanelContainer/+1 Seasons"
@onready var add_person: Button = $PanelContainer/AddPerson
@onready var event_popup_btn: Button = $PanelContainer/EventPopup
@onready var event_pop_up: PopupPanel = %EventPopUp

func _ready() -> void:
	left_draw_btn.pressed.connect(_on_left_draw_pressed)
	right_draw_btn.pressed.connect(_on_right_draw_pressed)
	add_gold.pressed.connect(_on_add_gold_pressed)
	__1_seasons.pressed.connect(_on_plus_one_seasons_pressed)
	add_person.pressed.connect(_on_add_person_pressed)
	event_popup_btn.pressed.connect(_on_event_pop_up_pressed)

func _on_left_draw_pressed() -> void:
	CheatManager.on_left_draw_pressed()

func _on_right_draw_pressed() -> void:
	CheatManager.on_right_draw_pressed()
	
func _on_add_gold_pressed() -> void:
	DataManager.add_gold(1)
	
func _on_add_person_pressed() -> void:
	var person: Person = Person.new()
	DataManager.add_person_to_population(person)

func _on_plus_one_seasons_pressed() -> void:
	DataManager.increase_seasons()

func _on_event_pop_up_pressed() -> void:
	if event_pop_up.visible:
		event_pop_up.hide()
	else:
		event_pop_up.popup()
