extends PanelContainer

const Effect = Classes.Effect

@onready
var AlchemyEngine = get_tree().get_first_node_in_group("Engines")

@export
var background_panel: Panel

@export
var effects_rich_label: RichTextLabel

@onready
var DEFAULT_TEXT = effects_rich_label.text

@onready
var ReviewContainer = get_node("ReviewContainer")


func set_in_front(val: bool):
	AlchemyEngine.asking_for_save = val
	visible = val
	background_panel.visible = val
	if not val:
		effects_rich_label.text = DEFAULT_TEXT

func set_effect(effect: Effect):
	effects_rich_label.text = effects_rich_label.text.replace("&",effect.name)

func _on_save_button_pressed() -> void:
	AlchemyEngine.clear_workplace()
	set_in_front(false)
	
