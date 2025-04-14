class Effect extends RefCounted:
	var name: String
	var target_gr: float
	var overdose_ef: Effect
	
	var is_bad: bool
		
	var upwards_tolerancy: float
	var downwards_tolerancy: float
	
	var perfect_dose = false
	
	
	@warning_ignore("shadowed_variable")
	func _init(name: String, target_gr: float, upwards_tolerancy: float = 0., downwards_tolerancy: float = 0., is_bad = false, overdose_ef: Effect = null) -> void:
		self.name = name
		self.target_gr = target_gr
		self.upwards_tolerancy = upwards_tolerancy
		self.downwards_tolerancy = downwards_tolerancy
		self.is_bad = is_bad
		self.overdose_ef = overdose_ef

	func _to_string() -> String:
		if perfect_dose:
			return name + "+"
		return name 
	
	func equals(ef: Effect) -> bool:
		return (self.name == ef.name) && (self.perfect_dose == ef.perfect_dose)

	# AI = ANITNFLAMATORY
	static var DROWZINESS: Effect = new("Drowziness", 0., 0., 1., true)
	static var ANTINFLAMATORY: Effect = new("Anti-inflamattory", 9., 1., 1., false, DROWZINESS)

	func is_effect_overdosed(gr: float) -> bool:
		return gr > target_gr + upwards_tolerancy

	func is_effect_underdosed(gr: float) -> bool:
		return gr < target_gr - downwards_tolerancy

	func is_effect_tolerated(gr: float) -> bool:
		return not is_effect_underdosed(gr) and not is_effect_overdosed(gr)

	func is_gr_perfect( gr: float) -> bool:
		perfect_dose = is_equal_approx(target_gr, gr)
		return perfect_dose

	func is_same_effect(ef: Effect):
		return (self.name == ef.name)

	static var list: Array[Effect] = [
		# GOOD
		ANTINFLAMATORY,
		
		# BAD
		DROWZINESS,
	]

class Ingredient extends RefCounted:
	var name: String
	var good_effect_a: Effect
	var gr_a: float
	var good_effect_b: Effect 
	var gr_b: float
	var is_special: bool

	var sweetness: float
	

	@warning_ignore("shadowed_variable")
	func _init(name: String, good_effect_a: Effect, gr_a: float, good_effect_b: Effect, gr_b: float, sweetness: float = 0., ) -> void:
		self.name = name
		self.is_special = is_special
		self.good_effect_a = good_effect_a
		self.gr_a = gr_a
		self.good_effect_b = good_effect_b
		self.gr_b = gr_b
		self.sweetness = sweetness
		
	
	static var MINT: Ingredient = new("Menta", Effect.ANTINFLAMATORY, 3., null, 0., 0.5)
	static var SUGAR: Ingredient = new("Azúcar", null, 3., null, 0., 0.25)
	
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
