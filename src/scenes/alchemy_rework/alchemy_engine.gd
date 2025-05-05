extends Node

const Ingredient = Classes.Ingredient
const Effect = Classes.Effect
const Potion = Classes.Potion

@onready
var GameManager: Node = get_tree().get_first_node_in_group("GameManager")

@export var workplace_tilemap_layer: TileMapLayer
@export var ghost_tilemap_layer: TileMapLayer

@export var save_popup: PanelContainer

var effects: Dictionary[int,int] = {}
var effects_of_potion: Array[Effect]

var pattern_position_dict: Dictionary[Vector2i, PackedVector2Array] = {}

var last_hovered_cell: Vector2i

var asking_for_save = false

var saved_mix_dict: Dictionary[String, Array]

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
	effects.clear()
	for cell in workplace_tilemap_layer.get_used_cells():
		var effect_index: int = workplace_tilemap_layer.get_cell_tile_data(cell).get_custom_data("Effect")
		if not effect_index > 0: continue # Early return for non effect tiles
		if effect_index not in effects.keys():
			effects[effect_index] = 1
		else:
			effects[effect_index] += 1
	effects_of_potion = []
	for i in effects.size():
		effects_of_potion.append(Classes.EffectWheel.list[i].get_effect_at(effects[i + 1]))
	
	if effects_of_potion.size() > 0:
		if effects_of_potion.size() > 2:
			save_popup.set_effects_in_label(effects_of_potion[0].name, effects_of_potion[1].name, effects_of_potion[2].name)
		elif effects_of_potion.size() > 1:
			save_popup.set_effects_in_label(effects_of_potion[0].name, effects_of_potion[1].name)
		else:
			save_popup.set_effects_in_label(effects_of_potion[0].name)
		save_popup.set_in_front(true)
	
	

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

func clear_worlplace():
	for position: Vector2i in pattern_position_dict.keys():
		_remove_pattern_at(position)

func _on_potion_finished() -> void:
	finish_potion()
