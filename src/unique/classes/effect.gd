class Effect extends RefCounted:
	var name: String
	var effect_id: int
	var level: int
	
	@warning_ignore("shadowed_variable")
	func _init(name: String, effect_id: int = -1, level: int = 1) -> void:
		self.name = name
		self.effect_id = effect_id
		self.level = level
		
	func _to_string() -> String:
		return name 

	func equals(ef: Effect) -> bool:
		return (self.name == ef.name)
	
	func clone() -> Effect:
		return new(name,effect_id,level)

	static var ANTI_INFLAMATORY: Effect = new("Antiinflamatorio")
	static var ANTI_HISTAMINIC: Effect = new("Antihistamínico")
	static var LAXATIVE: Effect = new("Laxante")
	static var ANTI_ACID: Effect = new("Antiácido")
	static var OPIATE: Effect = new("Opiáceo")
	static var ANTI_BIOTIC: Effect = new("Antibiótico")
	static var ANTI_PARASITIC: Effect = new("Antiparasital")
	static var MUCOLITIC: Effect = new("Mucolítico")
	static var ANTI_TUSSIVE: Effect = new("Antitusivo (Tos)")
	static var NARCOTIC: Effect = new("Narcótico")
	static var ANTI_PIRETIC: Effect = new("Antipirético")
	static var ANTI_FUNGHAL: Effect = new("Antifúngico")
	

	func is_same_effect(ef: Effect):
		return (self.name == ef.name)

	static var list: Array[Effect] = [
		ANTI_INFLAMATORY,
		ANTI_PIRETIC,
		ANTI_ACID,
		ANTI_TUSSIVE,
		
		ANTI_BIOTIC,
		ANTI_HISTAMINIC,
		ANTI_PARASITIC,
		ANTI_FUNGHAL,
		
		LAXATIVE,
		OPIATE,
		MUCOLITIC,
		NARCOTIC,
	]

class EffectWheel extends RefCounted:
	var effects: Dictionary[float, Effect]
	var wheel_size: float
	func _init(effects: Array[Effect], positions: Array[float], size: float = 1.):
		positions.sort()
		for i in range(effects.size()):
			self.effects[positions[i]] = effects[i]
		self.wheel_size = size
	
	func get_effect_at(value: int):
		var effect_level = clamp(value / wheel_size,1,100)
		value = value % int(wheel_size)
		var last_effect: Effect = effects.values()[0]
		for key in effects.keys():
			print("( ",key," > ",float(value) / wheel_size, " )?")
			if key > float(value) / wheel_size:
				var effect_to_return: Effect = Effect.new(last_effect.name, last_effect.effect_id,effect_level)
				return effect_to_return
			last_effect = effects[key]
	
	static var GREEN_WHEEL = new(
		[Effect.ANTI_BIOTIC,Effect.ANTI_HISTAMINIC, Effect.ANTI_PARASITIC, Effect.ANTI_FUNGHAL],
		[.25,.50,.75,1],
		10)
	
	static var ORANGE_WHEEL = new(
		[Effect.ANTI_BIOTIC,Effect.ANTI_HISTAMINIC, Effect.ANTI_ACID, Effect.ANTI_TUSSIVE],
		[.5,.7,.75,1],
		10)

	static var BLUE_WHEEL = new(
		[Effect.LAXATIVE,Effect.OPIATE, Effect.MUCOLITIC, Effect.NARCOTIC],
		[.35,.45,.90,1], 
		10)
	
	static var list: Array[EffectWheel] = [
		GREEN_WHEEL,
		BLUE_WHEEL,
		ORANGE_WHEEL,
	]
