const Ingredient = Classes.IngredientLib.Ingredient
const Effect = Classes.IngredientLib.Effect

enum HIDE_TYPE {
	NONE = -1,
	IMAGE = 0,
	INGREDIENT = 1
}

class Potion extends RefCounted:
	var name: String
	var effect: Effect
	var potion_flask: int
	var hide_type: HIDE_TYPE
	
	
	
	static var EMPTY = new("",null)
	
	static func get_potion_by_name(name: String) -> Potion:
		for potion in list.keys():
			if potion.name == name:
				return potion
		return null
	
	static var list: Dictionary[Potion, bool] = {
		new("Afisirox", Effect.ANTI_BIOTIC, 0, 1): false,
		new("", Effect.ANTI_PIRETIC, 0, 0): false,
		new("", Effect.LAXATIVE, 0 ,1): false,
		
		new("", Effect.ANTI_ACID, 1): false,
		new("", Effect.ANTI_FUNGHAL, 1): false,
		new("", Effect.ANTI_HISTAMINIC, 1): false,
		new("", Effect.ANTI_PARASITIC, 1): false,
		
		new("", Effect.NARCOTIC, 2): false,
		new("", Effect.OPIATE, 2): false,
		new("", Effect.MUCOLITIC, 2): false,
		new("", Effect.ANTI_PIRETIC, 2): false, # I NEED MORE EFFECTS
		new("", Effect.ANTI_PIRETIC, 2): false,
		new("", Effect.ANTI_PIRETIC, 2): false,
		new("", Effect.ANTI_PIRETIC, 2): false,
		new("", Effect.ANTI_PIRETIC, 2): false,
		
		new("", Effect.ANTI_PIRETIC, 2): false,
		new("", Effect.ANTI_PIRETIC, 2): false,
		
	}
	
	static var MEDICINE_DICT: Dictionary[Dictionary, Potion] = {
		{1:5 , 2:5, 3:4, 4:8}:list.keys()[0],
		{2:10, 3:4, 4:4, 5:4}:list.keys()[1],
		{1:10, 3:4, 4:4, 5:4}:list.keys()[2],
		{1:5,2:5, 4:8, 5:4}:list.keys()[15],
		{1:5,2:5, 3:4, 4:4, 5:4}:list.keys()[16],
		
		{6: 4, 7:6, 8:4, 9:2}:list.keys()[3],
		{6: 8, 7:6, 9:2}:list.keys()[4],
		{6: 8, 7:3, 8:4,9:1}:list.keys()[5],
		{6:8, 7:6, 8: 2}:list.keys()[6],
		
		{10: 5, 11:6, 14: 4, 15:4, 16: 5}:list.keys()[7],
		{10: 5, 11:6, 12: 3, 13:2, 14:4, 15:4}:list.keys()[8],
		{10: 5, 12:6, 13:4, 14:4, 16:5}:list.keys()[9],
		{12:3, 13:4, 14:8, 15:4, 16:5 }:list.keys()[10],
		{10:5, 11:12, 13:2, 16:5}:list.keys()[11],
		{10: 5, 12:6, 15:8, 16:5}:list.keys()[12],
		{10: 5, 11:6, 13:4, 14:4, 16:5}:list.keys()[13],
		{10:5, 11:6, 12:3, 13:2, 14:8}:list.keys()[14],
		#10.5 11.6 13.4 45.4 16.5
	}
	
	@warning_ignore("shadowed_variable")
	func _init(name:String, effect: Effect, potion_flask: int = 0, hide_type: int = HIDE_TYPE.INGREDIENT) -> void:
		self.name = name
		self.effect = effect
		self.potion_flask = potion_flask
		self.hide_type = hide_type

	func duplicate() -> Potion:
		var dup = new(self.name,self.effect)
		return dup
	
	static func from_pattern(pattern: Dictionary[int,int]):
		return MEDICINE_DICT[pattern]
	
	func _to_string() -> String:
		return self.name + " - " + self.effect._to_string()
	
	func potion_ingredient_effect_text() -> String:
		var potion_ingredients_text: String = ""
		var potion_effect_dict = Potion.MEDICINE_DICT.find_key(self)
		
		if hide_type == HIDE_TYPE.NONE || Potion.list[self]:
			for key in potion_effect_dict.keys():
				potion_ingredients_text += str(potion_effect_dict[key] / Ingredient.list[key - 1].pattern_block_count) + "x " + Ingredient.list[key - 1].name + "\n"
				prints(potion_effect_dict[key],"/",Ingredient.list[key - 1].pattern_block_count)
		elif hide_type == HIDE_TYPE.INGREDIENT:
			var sw = 0
			for key in potion_effect_dict.keys():
				if sw == 0:
					potion_ingredients_text += str(potion_effect_dict[key] / Ingredient.list[key - 1].pattern_block_count) + "x " + Ingredient.list[key - 1].name + "\n"
				else: 
					potion_ingredients_text += "?x ?" + "\n"
				sw += 1
		return potion_ingredients_text
