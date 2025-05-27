const Effect = Classes.Effect
const tileset_for_patterns: TileSet = preload("res://src/unique/extras/tileset_alchemy.tres")

class Ingredient extends RefCounted:
	var name: String
	var patterns: Array[TileMapPattern]
	var pattern_block_count: int
	

	@warning_ignore("shadowed_variable")
	func _init(name: String, starting_pattern_pos: int, ending_pattern_pos: int) -> void:
		self.name = name
		
		for i in range(starting_pattern_pos, ending_pattern_pos + 1):
			self.patterns.append(tileset_for_patterns.get_pattern(i))
			self.pattern_block_count = tileset_for_patterns.get_pattern(i).get_used_cells().size()


	static var FIRST_PUZZLE_PIECE_A: Ingredient = new("Menta", 0, 3)
	static var FIRST_PUZZLE_PIECE_B: Ingredient = new("Champiñón", 4, 7)
	static var FIRST_PUZZLE_PIECE_C: Ingredient = new("Abeja", 8, 11)
	static var FIRST_PUZZLE_PIECE_D: Ingredient = new("Lavanda", 12, 15)
	static var FIRST_PUZZLE_PIECE_E: Ingredient = new("Diente de leon", 16, 19)
	
	static var SECOND_PUZZLE_PIECE_A: Ingredient = new("Pata de rana", 20, 23)
	static var SECOND_PUZZLE_PIECE_B: Ingredient = new("Hueso pequeño", 24, 27)
	static var SECOND_PUZZLE_PIECE_C: Ingredient = new("Diente de coyote", 28, 31)
	static var SECOND_PUZZLE_PIECE_D: Ingredient = new("Pelo de roedor", 32, 35)
	
	static var THIRD_PUZZLE_PIECE_A: Ingredient = new("Limo", 36, 39)
	static var THIRD_PUZZLE_PIECE_B: Ingredient = new("Agua", 40, 43)
	static var THIRD_PUZZLE_PIECE_C: Ingredient = new("Aceite", 44, 47)
	static var THIRD_PUZZLE_PIECE_D: Ingredient = new("Zumo de uva", 48, 51)
	static var THIRD_PUZZLE_PIECE_E: Ingredient = new("Alcohol", 52, 55)
	static var THIRD_PUZZLE_PIECE_F: Ingredient = new("Leche", 56, 59)
	static var THIRD_PUZZLE_PIECE_G: Ingredient = new("Vinagre", 60, 63)
	
	
	
	
	static var list: Array[Ingredient] = [
		FIRST_PUZZLE_PIECE_A,
		FIRST_PUZZLE_PIECE_B,
		FIRST_PUZZLE_PIECE_C,
		FIRST_PUZZLE_PIECE_D,
		FIRST_PUZZLE_PIECE_E,
		
		SECOND_PUZZLE_PIECE_A,
		SECOND_PUZZLE_PIECE_B,
		SECOND_PUZZLE_PIECE_C,
		SECOND_PUZZLE_PIECE_D,
		
		THIRD_PUZZLE_PIECE_A,
		THIRD_PUZZLE_PIECE_B,
		THIRD_PUZZLE_PIECE_C,
		THIRD_PUZZLE_PIECE_D,
		THIRD_PUZZLE_PIECE_E,
		THIRD_PUZZLE_PIECE_F,
		THIRD_PUZZLE_PIECE_G,
	]

	static var texture_dict: Dictionary[Ingredient,Texture2D] = {
		FIRST_PUZZLE_PIECE_A: null,
		FIRST_PUZZLE_PIECE_B: null,
		FIRST_PUZZLE_PIECE_C: null,
		FIRST_PUZZLE_PIECE_D: null,
		FIRST_PUZZLE_PIECE_E: null,
		
		SECOND_PUZZLE_PIECE_A: null,
		SECOND_PUZZLE_PIECE_B: null,
		SECOND_PUZZLE_PIECE_C: null,
		SECOND_PUZZLE_PIECE_D: null,
		
		THIRD_PUZZLE_PIECE_A: null,
		THIRD_PUZZLE_PIECE_B: null,
		THIRD_PUZZLE_PIECE_C: null,
		THIRD_PUZZLE_PIECE_D: null,
		THIRD_PUZZLE_PIECE_E: null,
		THIRD_PUZZLE_PIECE_F: null,
		THIRD_PUZZLE_PIECE_G: null,
	}

	
	static func get_ingredient_by_name(target: String) -> Ingredient:
		for ingredient: Ingredient in list:
			if ingredient.name.to_lower() == target.to_lower():
				return ingredient
		return null

	func _to_string() -> String:
		return name
