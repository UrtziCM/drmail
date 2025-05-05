extends Node

# STAGE CAMERA
@export_category("Stage camera settings")
@export
var stage_camera: Camera2D
@export
var stages: Dictionary[String,Vector2i]
@export
var animation_duration: float = 0.5
var current_stage = Vector2i.ZERO

# ENVELOPE STAGE
@export_category("Envelope stage settings")
@export
var envelope_stage: Node2D

# ALCHEMY STAGE
@export_category("Alchemy stage settings")
@export
var alchemy_stage: Node2D
@onready
var saved_mix_dict

func _ready() -> void:
	# Setup camera stuff
	stage_camera.stages = stages
	stage_camera.movement_animation_duration = animation_duration
	await alchemy_stage.ready
	saved_mix_dict = alchemy_stage.get_node("AlchemyEngine").saved_mix_dict


func _camera_stage_changed(stage: Vector2i) -> void:
	current_stage = stage
