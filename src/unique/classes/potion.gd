const Ingredient = Classes.IngredientLib.Ingredient
const Effect = Classes.IngredientLib.Effect

class Potion extends RefCounted:
	var name: String
	
	var ingredients: Array[Ingredient]
	var effects: Array[Effect]
	
	var sweetness: float
	
	static var EMPTY = new([], [])
	
	@warning_ignore("shadowed_variable")
	func _init(ingredients:Array[Ingredient], effects: Array[Effect]) -> void:
		self.ingredients = ingredients
		self.effects = effects

	
	func clear():
		ingredients = []
		effects = []
		sweetness = 0.

	func is_potion_harming() -> bool:
		for effect in effects:
			if effect.is_bad:
				return true
		return false
	
	func _to_string() -> String:
		return "Ingredients: " + str(ingredients) + "\nEffects: " + str(effects) + "\nSweetness: " + str(sweetness) + "\n\t- Is sweetness fine? " + str(is_sweetness_ok())

	func add_effect(ef: Effect):
		effects.append(ef)

	func add_ingredient(ing: Ingredient):
		ingredients.append(ing)
	
	func is_sweetness_ok() -> bool:
		return (sweetness <= 1.0) and (sweetness >= -1.0)
		
	func duplicate() -> Potion:
		var dup = new(self.ingredients, self.effects)
		dup.sweetness = sweetness
		
		return dup
