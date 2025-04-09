extends CharacterBody2D

var dragging: bool = false

@onready
var splash_cast: RayCast2D = get_node("SplashCast")
@onready
var AlchemyEngine: Node = get_tree().get_first_node_in_group("Engines")

func _process(delta: float) -> void:
	if dragging:
		position = get_viewport().get_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and dragging:
		_drop()
		dragging = false;
		

func _drop():
	var drop_tween: Tween = create_tween()
	drop_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	drop_tween.set_ease(Tween.EASE_IN_OUT)
	drop_tween.set_trans(Tween.TRANS_LINEAR)
	drop_tween.parallel().tween_property(self,"scale",Vector2.ZERO,1)
	drop_tween.parallel().tween_property(self,"rotation_degrees",90,1)
	await drop_tween.finished
	_splash()
	queue_free()

func _splash():
	# Play wave / shockwave shader
	# Play water plop sound
	# Splash particles
	if splash_cast.is_colliding():
		AlchemyEngine.add_ingredient(self)
		
	pass 
