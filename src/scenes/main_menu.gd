extends Control

const main_scene = preload("res://src/scenes/main/main_game.tscn")

func _on_button_pressed() -> void:
	# go to main scene
	get_tree().change_scene_to_packed(main_scene)


func _on_button_2_pressed() -> void:
	#exit
	get_tree().quit()
