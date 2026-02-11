extends HousingStructures
class_name House

func _init(
	name_: String = "House",
	description_: String = "A house for people to live in. To increase your population you need to increase your max housing by building more houses.",
	type_: Enums.MapObjectTypes = Enums.MapObjectTypes.STRUCTURES,
	#coords_: Vector2i = Vector2i.ZERO,
	cost_: Dictionary = {Enums.CostTypes.GOLD: 20},
	max_people_: int = 4,
	people_: Array[Person] = [Person.new(),Person.new()],
	structure_type_: Enums.StructureTypes = Enums.StructureTypes.HOUSE,
	atlas_source_id_: int = 0,
	atlas_coords_: Vector2i = Vector2i(15,31)
) -> void:
	super._init(name_, description_, type_, cost_)
	self.max_people = max_people_
	self._people = people_
	self.structure_type = structure_type_
	self.atlas_source_id = atlas_source_id_
	self.atlas_coords = atlas_coords_
