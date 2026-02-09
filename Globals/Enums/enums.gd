extends Node

enum MapObjectTypes {
	STRUCTURES,
	TREES,
	ROCKS,
	MOUNTAINS,
	WATER,
	ROAD,
	GRASS
}

enum CostTypes {
	GOLD
}

enum StructureTypes {
	ZERO,
	HOUSE,
	FIELD,
	WINDMILL
}

enum EventFlags {
	LORDISSATISFIED,
	LOARDISVENGEFULL,
	DUCKTALES,
	BROKENWINDMILL
}

enum EventTypes {
	EVENT,
	HARVEST,
	PRODUCTION,
	SALE,
	POPULATION
}
