extends Node2D

const Potion = Classes.Potion

@onready
var mix_dict: Dictionary[String, Potion] = get_tree().get_first_node_in_group("GameManager").saved_mix_dict
@onready
var NameLabel: Label = get_node("PanelContainer/MarginContainer/VBoxContainer/NameLabel")
@onready
var EffectsLabel: RichTextLabel = get_node("PanelContainer/MarginContainer/VBoxContainer/EffectsLabel")
@onready
var DEFAULT_EFFECTS_TEXT: String = EffectsLabel.text
@onready
var WorksWithLabel: RichTextLabel = get_node("PanelContainer/MarginContainer/VBoxContainer/WorksWithLabel")

var currently_shown = -1

@onready
var liquid_ball: TextureRect = get_node("LiquidBall")

func _process(delta: float) -> void:
	_refresh_ui()

func _ready() -> void:
	liquid_ball.visible = true

func _refresh_ui():
	var index = 0
	for mix in mix_dict.values():
		if index == currently_shown:
			set_focused_mix_by_name(mix.name)
		index += 1

func set_focused_mix_by_name(mix_name: String):
	NameLabel.text = mix_name
	
