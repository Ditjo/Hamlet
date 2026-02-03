class_name Person

extends Resource

var rng = RandomNumberGenerator.new()

var person_name: String
var age: int
var home: Vector2
var job: Vector2

func _init(
	name_: String = "",
	age_: int = 20,
	home_: Vector2 = Vector2.ZERO,
	job_: Vector2 = Vector2.ZERO
) -> void:
	person_name = name_
	age = age_
	home = home_
	job = job_

func _resolve_assets() -> void:
	pass

func generate_person() -> void:
	person_name = get_name()
	age = randi_range(18,63)
	home = Vector2.ZERO
	job = Vector2.ZERO
