extends PanelContainer

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
@onready
var NameAskingContainer = get_node("NameAskingContainer")

func set_in_front(val: bool):
	AlchemyEngine.asking_for_save = true
	visible = val
	background_panel.visible = val
	

func set_effects_in_label(effect1: String, effect2: String = "", effect3: String = ""):
	effects_rich_label.text = effects_rich_label.text.replace("$Effect1", effect1)
	effects_rich_label.text = effects_rich_label.text.replace("$Effect2", effect2)
	effects_rich_label.text = effects_rich_label.text.replace("$Effect3", effect3)



func _on_save_button_pressed() -> void:
	AlchemyEngine.clear_worlplace()
	clear()

func _on_delete_button_pressed() -> void:
	
	clear()

func clear():
	effects_rich_label.text = DEFAULT_TEXT
	set_in_front(false)
	AlchemyEngine.asking_for_save = false
