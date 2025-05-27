extends VBoxContainer

var potion_index = 0

const POTION_TUTORIAL = preload("res://assets/potions/tutorial_potion.png")
const POTION_TRI = preload("res://assets/potions/triangle_potion.png")
const POTION_VIAL = preload("res://assets/potions/vial_potion.png")

const ALCHEMY_TILESET = preload("res://src/unique/extras/tileset_alchemy.tres")

const POTIONS = [POTION_TUTORIAL, POTION_VIAL,POTION_TRI]

@onready var potion_preview: TextureRect = get_node("MarginContainer/HBoxContainer/PotionPreview")
@export var workplace_tilemaplayer: TileMapLayer
@export var InventoryHandler: Node
@export var AlchemyEngine: Node

const PATTERN_STARTING_POS: Vector2i = Vector2i(-7, -6)

var POTION_PATTERNS = [
	ALCHEMY_TILESET.get_pattern(64),
	ALCHEMY_TILESET.get_pattern(65),
	ALCHEMY_TILESET.get_pattern(66),
]

func update_potion_sprite():
	potion_preview.texture = POTIONS[potion_index]
	AlchemyEngine.chosen_vial = potion_index

func _on_button_next_pressed() -> void:
	potion_index = (potion_index + 1) % 3
	update_potion_sprite()
	AlchemyEngine.clear_workplace()
	change_potion_pattern()
	InventoryHandler._set_pieces(potion_index)

func _on_previous_button_pressed() -> void:
	potion_index = (potion_index - 1) % 3
	if potion_index < 0:
		potion_index += 3
	update_potion_sprite()
	change_potion_pattern()
	InventoryHandler._set_pieces(potion_index)
	

func change_potion_pattern():
	workplace_tilemaplayer.clear()
	workplace_tilemaplayer.set_pattern(PATTERN_STARTING_POS,POTION_PATTERNS[potion_index])
