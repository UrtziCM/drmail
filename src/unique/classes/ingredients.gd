class Effect:
	var name: String
	var target_gr: float
	var is_bad: bool
	
	var upwards_tolerancy: float
	var downward_tolerancy: float
	
	func _init(name: String, target_gr: float, upwards_tolerancy: float = 0., downward_tolerancy: float = 0., is_bad = false) -> void:
		self.name = name
		self.target_gr = target_gr
		self.is_bad = is_bad

	# AI = ANITNFLAMATORY
	static var ANTINFLAMATORY: Effect = new("Anti-inflamattory", 9., 1., 1., false)


	static var list: Array[Effect] = [
		ANTINFLAMATORY,
		
	]

class Ingredient:
	var name: String
	var good_effect_a: Effect
	var gr_a: float
	var good_effect_b: Effect 
	var gr_b: float
	var bad_effect: Effect
	var gr_bad: float

	func _init(name: String, good_effect_a: Effect, gr_a: float, good_effect_b: Effect, gr_b: float, bad_effect: Effect, gr_bad: float ) -> void:
		self.name = name
		
		self.good_effect_a = good_effect_a
		self.gr_a = gr_a
		self.good_effect_b = good_effect_b
		self.gr_b = gr_b
		
		self.bad_effect = bad_effect
		self.gr_bad = gr_bad
	
	static var MINT: Ingredient = new("Menta", Effect.ANTINFLAMATORY, 3., null, 0., null, 0.)
	
	static var list: Array[Ingredient] = [
		MINT
	]
	
	static func get_ingredient_by_name(name: String) -> Ingredient:
		for ingredient: Ingredient in list:
			if ingredient.name.to_lower() == name.to_lower():
				return ingredient
		return null
