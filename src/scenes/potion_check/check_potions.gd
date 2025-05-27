extends Node2D

const Potion = Classes.Potion

const POTION_TUTORIAL = preload("res://assets/potions/tutorial_potion.png")
const POTION_TRI = preload("res://assets/potions/triangle_potion.png")
const POTION_VIAL = preload("res://assets/potions/vial_potion.png")

@onready
var NameLabel: Label = get_node("PanelContainer/HBoxContainer/PageLeft/VBoxContainer/NameLabel")
@onready
var IngredientsRichLabel: RichTextLabel = get_node("PanelContainer/HBoxContainer/PageRight/VBoxContainer/IngredientsRichLabel")
@onready
var DEFAULT_EFFECTS_TEXT: String = IngredientsRichLabel.text
@onready
var WorksWithLabel: RichTextLabel = get_node("PanelContainer/HBoxContainer/PageLeft/VBoxContainer/WorksWithLabel")
@onready
var PotionFlask: TextureRect = get_node("PanelContainer/HBoxContainer/PageLeft/VBoxContainer/PotionFlask")


var current_page_index = 0

@onready
var TOTAL_POTION_COUNT = Potion.list.size()

func show_page(idx: int):
	var potion_of_this_page: Potion = Potion.list.keys()[current_page_index]
	NameLabel.text = potion_of_this_page.name
	IngredientsRichLabel.text = potion_of_this_page.potion_ingredient_effect_text()
	WorksWithLabel.text = potion_of_this_page.effect._to_string()
	
	if potion_of_this_page.potion_flask == 0:
		PotionFlask.texture = POTION_TUTORIAL
	elif potion_of_this_page.potion_flask == 1:
		PotionFlask.texture = POTION_VIAL
	elif potion_of_this_page.potion_flask == 2:
		PotionFlask.texture = POTION_TRI
	

func _ready() -> void:
	show_page(0)

func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	current_page_index = (current_page_index + 1) % TOTAL_POTION_COUNT
	show_page(current_page_index)


func _on_previous_button_pressed() -> void:
	current_page_index = (current_page_index - 1) % TOTAL_POTION_COUNT
	show_page(current_page_index)
