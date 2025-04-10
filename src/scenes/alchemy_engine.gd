extends Node

const Ingredient = preload("res://src/unique/classes/ingredients.gd")

var effects: Array[String]

var raycast_tweens: Array[Tween] = []

var potion: Dictionary[String, float] = {}
var potion_effects: Array[Ingredient.Effect]

@export_range(0,10,0.05)
var spin_slowing_speed: float
@export_range(0,10,0.05)
var spin_accel_speed: float
@export_range(0,100,0.25)
var potion_ending_speed: float

var spinning_speed: float

@onready
var spinning_raycasts: Array[Node] = get_node("../CauldronArea/SpinRaycast").get_children()

func _process(delta: float) -> void:
	for raycast: RayCast2D in spinning_raycasts:
		if raycast.is_colliding():
			spinning_speed = clampf(spinning_speed + (spin_accel_speed * delta) * 60, 0., potion_ending_speed + 5)
	
	if spinning_speed > 0:
		spinning_speed = clampf(spinning_speed - (spin_slowing_speed * delta) * 60, 0., potion_ending_speed + 5);
	if spinning_speed > potion_ending_speed:
		finish_potion()



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




func finish_potion():
	if _is_potion_harming():
		pass
	print(potion)
	spinning_speed = 0.
	potion.clear()


func _is_potion_harming() -> bool:
	for effect in potion_effects:
		if potion[effect.name] > effect.target_gr + effect.upwards_tolerancy:
			return true
	return false

func new_effect_added(effect: Ingredient.Effect, gramage: float):
	pass

func gramage_added_to_existing_effect(effect: Ingredient.Effect, gramage: float):
	pass


func _on_spoon_click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
