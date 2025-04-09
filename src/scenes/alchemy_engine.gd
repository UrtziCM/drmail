extends Node

const Ingredient = preload("res://src/unique/classes/ingredients.gd")

var effects: Array[String]

var potion: Dictionary[String, float] = {}
var potion_effects: Array[Ingredient.Effect]

func add_ingredient(ingredient: Ingredient.Ingredient) -> void:
	var index = 0
	var gramages = {
		0: ingredient.gr_a,
		1: ingredient.gr_b,
		2: ingredient.gr_bad
	}
	
	for effect in [ingredient.good_effect_a, ingredient.good_effect_b, ingredient.bad_effect]:
		if effect: # If effect is nil, early return
			var gramage = gramages[index]
			
			if potion.keys().find(effect.name) != -1: # Exists in array
				potion[effect.name] += gramage
				gramage_added_to_existing_effect(effect, gramage)
			else:
				potion[effect.name] = gramage
				new_effect_added(effect, gramage)
		index += 1
	print(potion)




func finish_potion():
	if _is_potion_harming():
		pass
	
	potion.clear()


func _is_potion_harming() -> bool:
	for effect in potion_effects:
		if potion[effect.name] > effect.target_gr + effect.upwards_tolerancy:
			return true
	return false

func new_effect_added(effect: Ingredient.Effect, gramage: float):
	print(gramage)

func gramage_added_to_existing_effect(effect: Ingredient.Effect, gramage: float):
	pass
