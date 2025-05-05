extends Node

const Ingredient = Classes.Ingredient
const Effect = Classes.Effect
const Potion = Classes.Potion

var potion: Potion

var potion_history: Array[Array] = []

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
		await get_tree().process_frame 
		# Await one frame so same pattern does not flash when hovering over cell in same pattern
		ghost_tilemap_layer.clear()
	last_hovered_cell = hovered_cell

func finish_potion():
	effects.clear()
	for cell in workplace_tilemap_layer.get_used_cells():
		var effect_index: int = workplace_tilemap_layer.get_cell_tile_data(cell).get_custom_data("Effect")
		if not effect_index > 0: continue # Early return for non effect tiles
		if effect_index not in effects.keys():
			effects[effect_index] = 1
		else:
			effects[effect_index] += 1
	print(effects)
	print("------------------------")
	var effects_of_potion = []
	for i in effects.size():
		effects_of_potion.append(Classes.EffectWheel.list[i].get_effect_at(effects[i + 1]))
	potion_history.append(effects_of_potion)
	print(potion_history[potion_history.size()-1])

func _input(event: InputEvent) -> void:
	_remove_pattern_if_clicked(event)

func _remove_pattern_if_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		var clicked_cell: Vector2i = workplace_tilemap_layer.local_to_map(workplace_tilemap_layer.get_local_mouse_position())
		if clicked_cell in pattern_position_dict.keys():
			for cell: Vector2i in pattern_position_dict[clicked_cell]:
				workplace_tilemap_layer.set_cell(cell)
				pattern_position_dict.erase(cell)

func _on_potion_finished() -> void:
	finish_potion()
