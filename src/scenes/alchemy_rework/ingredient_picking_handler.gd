extends Node

@export
var IngredientsItemList: ItemList
const Ingredient = Classes.Ingredient

var ingredient_draggable_instanceable: PackedScene = preload("res://src/instanceables/ingredient_draggable_rw/ingredient_draggable.tscn")



func _on_ingredient_clicked(index: int, _at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index != MOUSE_BUTTON_LEFT: # Only allow LClick
		return
	var ingredient_draggable = ingredient_draggable_instanceable.instantiate()
	ingredient_draggable.position = get_viewport().get_camera_2d().position + _at_position
	ingredient_draggable.ingredient = Ingredient.get_ingredient_by_name(IngredientsItemList.get_item_text(index))
	ingredient_draggable.index = index
	add_child(ingredient_draggable)
	ingredient_draggable.dragging = true
