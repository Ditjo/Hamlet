class_name Person

extends Resource

#var rng = RandomNumberGenerator.new()

var person_name: String
var age: int
var home: Vector2i
var job: Vector2i

func _init(
	name_: String = generate_name(),
	age_: int = min(randi_range(18,63),randi_range(18,63)),
	home_: Vector2 = Vector2i.ZERO,
	job_: Vector2 = Vector2i.ZERO
) -> void:
	person_name = name_
	age = age_
	home = home_
	job = job_

func _resolve_assets() -> void:
	pass

#func generate_person() -> void:
	#person_name = generate_name()
	#age = randi_range(18,63)
	#home = Vector2.ZERO
	#job = Vector2.ZERO

func generate_name() -> String:
	var forenames: Array = ["Ella", "Alma", "Nora", "Ida", "Freja", "Sofia", "Luna", "Olivia", "Agnes", "Asta", "Clara", "Emma", "Frida", "Alberte", "Ella", "Sofie", "Leah", "Sara", "William", "Oscar", "Carl", "Malthe", "Emil", "Valdemar", "Noah", "Aksel", "August", "Theo", "Alexander", "Jacob", "Lucas", "Oliver", "Isak", "Filip", "Sebastian", "Vincent"]
	var surnames: Array = ["Nielsen", "Jensen", "Hansen", "Pedersen", "Andersen", "Christensen", "Larsen", "Rasmussen", "Madsen", "Olsen", "Thomsen", "Poulsen", "Johansen", "Mortensen", "Karlsen", "Eriksen", "Berg", "Hagen", "Jacobsen", "Dahl", "Henriksen", "Lund"]
	var fullname: String = forenames.pick_random() + " " + surnames.pick_random()
	return fullname
