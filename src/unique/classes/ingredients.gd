const Effect = Classes.Effect

class Ingredient extends RefCounted:
	var name: String
	var good_effect_a: Effect
	var gr_a: float
	var good_effect_b: Effect 
	var gr_b: float
	var is_special: bool
	
	var desired_temperature: float

	var sweetness: float
	
	var pattern: TileMapPattern
	
	const tileset_for_patterns: TileSet = preload("res://src/unique/extras/tileset_alchemy.tres")

	@warning_ignore("shadowed_variable")
	func _init(name: String, pattern: TileMapPattern) -> void:
		self.name = name
		self.pattern = pattern


	static var MINT: Ingredient = new("Menta", tileset_for_patterns.get_pattern(0))
	static var SUGAR: Ingredient = new("Azúcar", tileset_for_patterns.get_pattern(2))
	
	static var list: Array[Ingredient] = [
		MINT,
		SUGAR
	]

	static var texture_dict: Dictionary[Ingredient,Texture2D] = {
		MINT: preload("res://icon.svg"),
		SUGAR: preload("res://icon.svg"),
	}

	
	static func get_ingredient_by_name(target: String) -> Ingredient:
		for ingredient: Ingredient in list:
			if ingredient.name.to_lower() == target.to_lower():
				return ingredient
		return null

	func _to_string() -> String:
		return name
