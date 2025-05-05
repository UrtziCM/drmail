const Effect = Classes.Effect
const Potion = Classes.Potion


class Symptom extends RefCounted:
	var name: String
	var description: String
	var counter_effect: Effect
	var symptom_level: int

	@warning_ignore("shadowed_variable")
	func _init(name: String, description: String, counter_effect: Effect, symptom_level: int) -> void:
		self.name = name
		self.description = description
		self.counter_effect = counter_effect
		self.symptom_level = symptom_level

	# ACHEs and PAINs
	static var HEAD_ACHE = new("Dolor de cabeza", "Le duele la cabeza", Effect.ANTI_INFLAMATORY ,1)
	static var CHEST_PAIN = new("Dolor de pecho", "Le duele el pecho", Effect.ANTI_INFLAMATORY, 2)
	static var TOOTH_ACHE = new("Dolor de muela", "Le duele la muela", Effect.ANTI_INFLAMATORY, 1)
	static var BACK_PAIN = new("Dolor de espalda", "Le duele la espalda", Effect.ANTI_INFLAMATORY, 3)
	static var TUMMY_ACHE = new("Dolor de abdomen", "Le duele el abdómen", Effect.ANTI_ACID, 1)
	
	# FEELings
	static var FEVER = new("Fiebre", "Tiene fiebre", Effect.ANTI_PIRETIC, 1)
	static var NAUSEA = new("Náuseas", "Está mareado", Effect.ANTI_HISTAMINIC, 2)
	
	# SPECIFICs
	static var COUGH = new("Tos", "Tose", Effect.ANTI_TUSSIVE, 1)
	static var FEET_FUNGI = new("Hongos en el pie", "Tiene un hongo en el pie", Effect.ANTI_FUNGHAL, 1)
	static var ALERGIC_REACTION = new("Reacción alérgica", "Tiene la cara hinchada", Effect.ANTI_HISTAMINIC, 1)
	static var INFECTION = new("Infeccion", "Tiene una herida infectada",Effect.ANTI_BIOTIC, 1)
	static var LEECH = new("Sanguijuela", "Tiene una sanguijuela", Effect.ANTI_PARASITIC, 1)
	
	# CANTs
	static var CANT_BREATH = new("","No puede respirar", Effect.ANTI_INFLAMATORY, 2 )
	static var CANT_SLEEP = new("Insomnio", "No puede dormir", Effect.NARCOTIC, 1)
	static var CANT_SWALLOW = new("", "No puede tragar", Effect.ANTI_INFLAMATORY, 2)
	static var CANT_BATHROOM = new("Estreñimiento", "No puede ir al baño", Effect.LAXATIVE, 1)
	


	static var list: Array[Symptom] = [
		HEAD_ACHE,
		CHEST_PAIN,
		TOOTH_ACHE,
		BACK_PAIN,
		TUMMY_ACHE,
		
		FEVER,
		NAUSEA,
		
		COUGH,
		FEET_FUNGI,
		ALERGIC_REACTION,
		INFECTION,
		LEECH,
		
		CANT_BREATH,
		CANT_SLEEP,
		CANT_SWALLOW,
		CANT_BATHROOM
		]


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

	static func create_random_illness():
		var random_symptoms: Array[Symptom] = []
		var total_symptom_count = randi_range(1,4)
		
		for _index in total_symptom_count:
			var rand_symptom = Symptom.list.pick_random()
			while rand_symptom in random_symptoms:
				rand_symptom = Symptom.list.pick_random()
			random_symptoms.append(rand_symptom)
		
		return new(random_symptoms)
		
