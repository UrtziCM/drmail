extends Node

const Potion = Classes.Potion

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

# DIARY STAGE
var unlocked_potions: Array[Potion]

var healed = 0
var deceased = 0

func _ready() -> void:
	# Setup camera stuff
	stage_camera.stages = stages
	stage_camera.movement_animation_duration = animation_duration
	await alchemy_stage.ready

func _process(delta: float) -> void:
	envelope_stage.set_score(healed, deceased)

func _camera_stage_changed(stage: Vector2i) -> void:
	current_stage = stage

func unlocked_potion_array():
	var unlocked_potions: Array[Potion] = []
	for key in Potion.list:
		if (Potion.list[key]):
			unlocked_potions.append(key)
	return unlocked_potions

func add_healed():
	healed += 1

func add_deceased():
	deceased += 1
