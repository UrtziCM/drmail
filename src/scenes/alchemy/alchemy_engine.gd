extends Node

const Ingredient = Classes.IngredientLib.Ingredient
const Effect = Classes.IngredientLib.Effect
const PotionClass = preload("res://src/unique/classes/potion.gd")

@export
var TemperatureHandler : Node

var effects: Array[String]

var raycast_tweens: Array[Tween] = []

var mix: Dictionary[String, float] = {}
var mix_ingredients : Array[Ingredient] = []
var mix_effects: Array[Effect] = []
var mix_sweetness = 0.

var potion: PotionClass.Potion

@export_category("Stiring")
@export_range(0,10,0.05)
var spin_slowing_speed: float
@export_range(0,10,0.05)
var spin_accel_speed: float
@export_range(0,100,0.25)
var potion_ending_speed: float

var spinning_speed: float

var potion_history: Array[PotionClass.Potion] = []

@onready
var spinning_raycasts: Array[Node] = get_node("../CauldronArea/SpinRaycast").get_children()

func _process(delta: float) -> void:
	for raycast: RayCast2D in spinning_raycasts:
		if raycast.is_colliding():
			spinning_speed = clampf(spinning_speed + (spin_accel_speed * delta) * 60, 0., potion_ending_speed + 5)
			raycast.enabled = false
			raycast.get_child(0).start()
	
	if spinning_speed > 0:
		spinning_speed = clampf(spinning_speed - (spin_slowing_speed * delta) * 60, 0., potion_ending_speed + 5);
	if spinning_speed > potion_ending_speed:
		finish_potion()


func add_ingredient(ingredient: Ingredient) -> void:
	mix_ingredients.append(ingredient)
	
	mix_sweetness += ingredient.sweetness
	
	var index = 0
	var gramages = [ingredient.gr_a, ingredient.gr_b]
	
	for effect in [ingredient.good_effect_a, ingredient.good_effect_b]:
		if effect: # If effect is nil, early return
			var gramage = gramages[index]
			
			if mix.keys().find(effect.name) != -1: # Exists in array
				mix[effect.name] += gramage
				gramage_added_to_existing_effect(effect, gramage)
			else:
				mix[effect.name] = gramage
				new_effect_added(effect, gramage)
		index += 1





func finish_potion():
	potion = PotionClass.Potion.EMPTY
	
	for effect: Effect in mix_effects:
		var this_effect_gr = mix[effect.name]
		
		if effect.is_effect_overdosed(this_effect_gr): # Se pasa
			potion.add_effect(effect.overdose_ef)
		elif effect.is_effect_underdosed(this_effect_gr):
			pass
		elif effect.is_gr_perfect(this_effect_gr): # Acierta
			effect.perfect_dose = true
			potion.add_effect(effect)
		elif effect.is_effect_tolerated(this_effect_gr): # No se pasa ni se queda corto pero se tolera
			potion.add_effect(effect)
	
	for ingredient: Ingredient in mix_ingredients:
		potion.add_ingredient(ingredient)

	spinning_speed = 0.
	mix.clear()
	mix_effects.clear()
	mix_ingredients.clear()
	
	potion.sweetness = mix_sweetness
	mix_sweetness = 0.
	
	potion.temperature = TemperatureHandler.temperature
	
	potion_history.append(potion.duplicate()) 
	potion.clear()
	print("---------------------------")
	print(potion_history)


@warning_ignore("unused_parameter")
func new_effect_added(effect: Effect, gramage: float):
	mix_effects.append(effect)

@warning_ignore("unused_parameter")
func gramage_added_to_existing_effect(effect: Effect, gramage: float):
	pass

func _raycast_timer_finished(raycastNum: int):
	var calling_node: RayCast2D = spinning_raycasts[raycastNum]
	calling_node.enabled = true
