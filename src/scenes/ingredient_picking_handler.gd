extends Node

@export
var IngredientsTab: TabContainer

var Ingredients = preload("res://src/unique/classes/ingredients.gd")
var ingredient_draggable_instanceable: PackedScene = preload("res://src/instanceables/ingredient_draggable/ingredient_draggable.tscn")



func _on_ingredient_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var ingredient = ingredient_draggable_instanceable.instantiate()
	ingredient.position = get_viewport().get_mouse_position()

	ingredient.ingredient = Ingredients.Ingredient.get_ingredient_by_name(IngredientsTab.get_child(IngredientsTab.current_tab).get_item_text(index))
	add_child(ingredient)
	ingredient.dragging = true
	
