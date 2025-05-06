const Ingredient = Classes.IngredientLib.Ingredient
const Effect = Classes.IngredientLib.Effect

class Potion extends RefCounted:
	var name: String
	var effects: Array[Effect]
	var counts: Dictionary[int, int]
	var mix_color: Color
	
	const orange = Color.ORANGE_RED
	const green = Color.GREEN
	const blue = Color.BLUE
	
	static var EMPTY = new([])
	
	@warning_ignore("shadowed_variable")
	func _init(effects: Array[Effect]) -> void:
		self.effects = effects

	func refresh_color_from_counts():
		var total_count = 0

		for value in counts.values():
			total_count += value
		

	func clear():
		effects = []

	func add_effect(ef: Effect):
		effects.append(ef)

	
	func duplicate() -> Potion:
		var dup = new(self.effects)
		return dup
