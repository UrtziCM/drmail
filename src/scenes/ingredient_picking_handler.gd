extends Node

var ingredient_draggable_instanceable: PackedScene = preload("res://src/instanceables/ingredient_draggable/ingredient_draggable.tscn")

var good_effect_a: String; var good_effect_a_gr: float 
var good_effect_b: String; var good_effect_b_gr: float 
var bad_effect: String   ; var bad_effect_gr: float 
var overdose_effect: String

func _on_ingredient_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var ingredient = ingredient_draggable_instanceable.instantiate()
	ingredient.position = get_viewport().get_mouse_position()
	add_child(ingredient)
	ingredient.dragging = true
