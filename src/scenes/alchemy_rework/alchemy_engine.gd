extends Node

const Ingredient = Classes.Ingredient
const Effect = Classes.Effect
const Potion = Classes.Potion

@onready
var GameManager: Node = get_tree().get_first_node_in_group("GameManager")
@export var InventoryHandler: Node

@export var workplace_tilemap_layer: TileMapLayer
@export var ghost_tilemap_layer: TileMapLayer

@export var save_popup: PanelContainer



var effects: Dictionary[int,int] = {}
var ingredients_of_potion: Dictionary[Vector2i, Ingredient]
var ingredient_index_dict: Dictionary[Ingredient, int]
var pattern_position_dict: Dictionary[Vector2i, PackedVector2Array] = {}

var last_hovered_cell: Vector2i

var chosen_vial = 0

var asking_for_save = false

func _process(delta: float) -> void:
	if not asking_for_save:
		var hovered_cell: Vector2i = workplace_tilemap_layer.local_to_map(workplace_tilemap_layer.get_local_mouse_position())
		if hovered_cell in pattern_position_dict.keys() and hovered_cell == last_hovered_cell:
			for cell: Vector2i in pattern_position_dict[hovered_cell]:
				ghost_tilemap_layer.set_cell(cell, 1,Vector2i(1,1),0)
		else:
			await get_tree().process_frame 
			# Await one frame so same pattern does not flash when hovering over cell in same pattern
			ghost_tilemap_layer.clear()
		last_hovered_cell = hovered_cell

func finish_potion():
	var total_effect_tile_count: int = 0
	effects.clear()
	for cell in workplace_tilemap_layer.get_used_cells():
		var effect_index: int = workplace_tilemap_layer.get_cell_tile_data(cell).get_custom_data("Effect")
		if not effect_index > 0: continue # Early return for non effect tiles
		if effect_index not in effects.keys():
			effects[effect_index] = 1
		else:
			effects[effect_index] += 1
		total_effect_tile_count += 1
	if (chosen_vial == 0 and total_effect_tile_count < 22):
		return
	if (chosen_vial == 1 and total_effect_tile_count < 16):
		return
	if (chosen_vial == 2 and total_effect_tile_count < 24):
		return
	effects.sort()
	var new_potion: Potion = Potion.from_pattern(effects)
	
	Potion.list[new_potion] = true
	show_finish_ui(new_potion)
	

func show_finish_ui(potion: Potion):
	# Establecer que efecto tiene la mezcla
	save_popup.set_effect(potion.effect)
	# Popup de nuevo más fondo show
	save_popup.set_in_front(true)

func dropped(ingredient: Node2D, first_pos: Vector2i):
	ingredients_of_potion.get_or_add(first_pos, ingredient.ingredient)
	ingredient_index_dict[ingredient.ingredient] = ingredient.index
	
	if ingredients_of_potion.values().count(ingredient.ingredient) >=2:
		InventoryHandler.set_disable_at(ingredient.index, true)

func _input(event: InputEvent) -> void:
	_remove_pattern_if_clicked(event)

func _remove_pattern_if_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and not asking_for_save:
		var clicked_cell: Vector2i = workplace_tilemap_layer.local_to_map(workplace_tilemap_layer.get_local_mouse_position())
		_remove_pattern_at(clicked_cell)

func _remove_pattern_at(position: Vector2i):
	if position in pattern_position_dict.keys():
		for cell: Vector2i in pattern_position_dict[position]:
			workplace_tilemap_layer.set_cell(cell)
			pattern_position_dict.erase(cell)
			if cell in ingredients_of_potion.keys():
				InventoryHandler.set_disable_at(ingredient_index_dict[ingredients_of_potion[cell]], false)
				ingredients_of_potion.erase(cell)
			

func clear_workplace():
	for position: Vector2i in pattern_position_dict.keys():
		_remove_pattern_at(position)
	pattern_position_dict.clear()
	

func _on_potion_finished() -> void:
	finish_potion()
