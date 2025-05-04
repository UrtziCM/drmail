extends Node2D

@onready
var navagent: NavigationAgent2D = get_child(0)

func _physics_process(delta: float) -> void:
	position = navagent.get_next_path_position()

func clear_navigation_layers():
	for i in 32:
		navagent.set_navigation_layer_value(i, false)

func set_navigation_layer_value(layer: int, value: bool):
	navagent.set_navigation_layer_value(layer, value)

func can_reach_position(target_pos: Vector2):
	navagent.target_position = target_pos
	await Engine.get_main_loop().physics_frame
	return navagent.is_target_reachable()
