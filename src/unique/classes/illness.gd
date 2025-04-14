const Effect = Classes.IngredientLib.Effect
const Potion = Classes.PotionLib.Potion


class Symptom extends RefCounted:
	var name: String
	var description: String
	var counter_effect: Effect

	var is_perfect_required: bool

	@warning_ignore("shadowed_variable")
	func _init(name: String, description: String, counter_effect: Effect, is_perfect_required: bool = false) -> void:
		self.name = name
		self.description = description
		self.counter_effect = counter_effect
		self.is_perfect_required = is_perfect_required

class Illness extends RefCounted:
	var symptoms: Array[Symptom]
	var cured_symptoms: Array[Symptom]

	@warning_ignore("shadowed_variable")
	func _init(symptoms: Array[Symptom]) -> void:
		self.symptoms = symptoms
		self.cured_symptoms = []

	func apply_potion(potion: Potion):
		for symptom: Symptom in symptoms:
			for effect: Effect in potion.effects:
				if symptom.counter_effect.equals(effect):
					if symptom.is_perfect_required and effect.perfect_dose:
						cured_symptoms.append(symptom)
					else:
						cured_symptoms.append(symptom)

	func is_cured() -> bool:
		return symptoms.size() == cured_symptoms.size()

	func cure_percentage() -> float:
		return float(cured_symptoms.size()) / float(symptoms.size())
