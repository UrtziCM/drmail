extends CharacterBody2D


const IngredientClass = preload("res://src/unique/classes/ingredients.gd")

var dragging: bool = false
@export_range(0.0,1.0,0.05,"or_greater")
var dropping_animation_length: float


@onready
var splash_cast: RayCast2D = get_node("SplashCast")
@onready
var AlchemyEngine: Node = get_tree().get_first_node_in_group("Engines")

var ingredient: IngredientClass.Ingredient

func _ready() -> void:
	get_viewport().get_camera_2d().connect("stage_changed", _stage_changed)

func _process(_delta: float) -> void:
	if dragging:
		position = get_viewport().get_camera_2d().position + get_viewport().get_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and dragging:
		_drop()
		dragging = false;
		

func _drop():
	if !splash_cast.is_colliding(): 
		queue_free()
	var drop_tween: Tween = create_tween()
	drop_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	drop_tween.set_trans(Tween.TRANS_SINE)
	drop_tween.parallel().tween_property(self,"scale",Vector2.ZERO,dropping_animation_length)
	drop_tween.parallel().tween_property(self,"rotation_degrees",90,dropping_animation_length)
	await drop_tween.finished
	_splash()
	queue_free()

func _splash():
	# Play wave / shockwave shader
	# Play water plop sound
	# Splash particles
	if splash_cast.is_colliding():
		AlchemyEngine.add_ingredient(self.ingredient) 


func _stage_changed(where_to: Vector2i):
	queue_free()
