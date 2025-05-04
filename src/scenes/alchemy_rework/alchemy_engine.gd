extends Node

const Ingredient = Classes.Ingredient
const Effect = Classes.Effect
const Potion = Classes.Potion

var potion: Potion

var potion_history: Array[Potion] = []

@export var workplace_tilemap_layer: TileMapLayer
@export var ghost_tilemap_layer: TileMapLayer

var effects: Dictionary[int,int] = {}

var pattern_position_dict: Dictionary[Vector2i, PackedVector2Array] = {}

var last_hovered_cell: Vector2i

func _process(delta: float) -> void:
	var hovered_cell: Vector2i = workplace_tilemap_layer.local_to_map(workplace_tilemap_layer.get_local_mouse_position())
	if hovered_cell in pattern_position_dict.keys() and hovered_cell == last_hovered_cell:
		for cell: Vector2i in pattern_position_dict[hovered_cell]:
			ghost_tilemap_layer.set_cell(cell, 1,Vector2i(1,1),0)
	else:
		ghost_tilemap_layer.clear()
	last_hovered_cell = hovered_cell

func add_ingredient(ingredient: Ingredient) -> void:
	pass


func finish_potion():
	pass

func _input(event: InputEvent) -> void:
	_remove_pattern_if_clicked(event)

func _remove_pattern_if_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		var clicked_cell: Vector2i = workplace_tilemap_layer.local_to_map(workplace_tilemap_layer.get_local_mouse_position())
		if clicked_cell in pattern_position_dict.keys():
			for cell: Vector2i in pattern_position_dict[clicked_cell]:
				workplace_tilemap_layer.set_cell(cell)
				pattern_position_dict.erase(cell)

@warning_ignore("unused_parameter")
func new_effect_added(effect: Effect, gramage: float):
	pass

@warning_ignore("unused_parameter")
func gramage_added_to_existing_effect(effect: Effect, gramage: float):
	pass

func _on_potion_finished() -> void:
	effects.clear()
	for cell in workplace_tilemap_layer.get_used_cells():
		var effect_index = workplace_tilemap_layer.get_cell_tile_data(cell).get_custom_data("Effect")
		if effect_index not in effects.keys():
			effects[effect_index] = 1
		else:
			effects[effect_index] += 1
	print(effects)
