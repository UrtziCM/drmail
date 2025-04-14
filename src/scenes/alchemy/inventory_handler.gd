extends Node

const Ingredient = Classes.IngredientLib.Ingredient

@export_category("UI Elements")
@export
var IngredientItemList: ItemList
@export
var ExtrasItemList: ItemList

var ingredient_inventory: Array[Ingredient] = []
var extras_inventory: Array[Ingredient] = []


func _ready() -> void:
	add_ingredient_to_inventory(Ingredient.MINT)
	add_ingredient_to_inventory(Ingredient.SUGAR)
	add_ingredient_to_inventory(Ingredient.SUGAR)
	add_ingredient_to_inventory(Ingredient.SUGAR)
	_refresh_ui()

func add_ingredient_to_inventory(ingredient: Ingredient, is_extra: bool = false):
	if not is_extra:
		ingredient_inventory.append(ingredient)
	else:
		extras_inventory.append(ingredient_inventory)

func _refresh_ui():
	IngredientItemList.clear()
	for ingredient: Ingredient in ingredient_inventory:
		IngredientItemList.add_item(ingredient.name, Ingredient.texture_dict[ingredient])
