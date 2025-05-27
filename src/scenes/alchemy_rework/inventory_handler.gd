extends Node

const Ingredient = Classes.Ingredient

@export_category("UI Elements")
@export
var IngredientItemList: ItemList

var ingredient_inventory: Array[Ingredient] = []

var FIRST_PUZZLE_PIECES: Array[Ingredient] = [
	Ingredient.FIRST_PUZZLE_PIECE_A,
	Ingredient.FIRST_PUZZLE_PIECE_B,
	Ingredient.FIRST_PUZZLE_PIECE_C,
	Ingredient.FIRST_PUZZLE_PIECE_D,
	Ingredient.FIRST_PUZZLE_PIECE_E,
]

var SECOND_PUZZLE_PIECES: Array[Ingredient] = [
	Ingredient.SECOND_PUZZLE_PIECE_A,
	Ingredient.SECOND_PUZZLE_PIECE_B,
	Ingredient.SECOND_PUZZLE_PIECE_C,
	Ingredient.SECOND_PUZZLE_PIECE_D,
]

var THIRD_PUZZLE_PIECES: Array[Ingredient] = [
	Ingredient.THIRD_PUZZLE_PIECE_A,
	Ingredient.THIRD_PUZZLE_PIECE_B,
	Ingredient.THIRD_PUZZLE_PIECE_C,
	Ingredient.THIRD_PUZZLE_PIECE_D,
	Ingredient.THIRD_PUZZLE_PIECE_E,
	Ingredient.THIRD_PUZZLE_PIECE_F,
	Ingredient.THIRD_PUZZLE_PIECE_G,
]

func _ready() -> void:
	_set_pieces(0)

func add_ingredient_to_inventory(ingredient: Ingredient, is_extra: bool = false):
	if not is_extra:
		ingredient_inventory.append(ingredient)

func _set_pieces(idx: int):
	IngredientItemList.clear()
	if idx == 0:
		for piece: Ingredient in FIRST_PUZZLE_PIECES:
			IngredientItemList.add_item(piece.name, Ingredient.texture_dict[piece], true)
	elif idx == 1:
		for piece: Ingredient in SECOND_PUZZLE_PIECES:
			IngredientItemList.add_item(piece.name, Ingredient.texture_dict[piece], true)
	elif idx == 2:
		for piece: Ingredient in THIRD_PUZZLE_PIECES:
			IngredientItemList.add_item(piece.name, Ingredient.texture_dict[piece], true)

func set_disable_at(index: int, value: bool):
	IngredientItemList.set_item_disabled(index, value)
