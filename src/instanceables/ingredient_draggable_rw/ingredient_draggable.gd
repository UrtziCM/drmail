extends CharacterBody2D

const Ingredient = Classes.Ingredient


var dragging: bool = false
@export_range(0.0,1.0,0.05,"or_greater")
var dropping_animation_length: float

@onready
var ghost_layer: TileMapLayer = get_tree().get_nodes_in_group("Workplace")[1]
@onready
var workplace: TileMapLayer = get_tree().get_nodes_in_group("Workplace")[0]

@export
var workplace_tileset: TileSet 


#@onready
#var splash_cast: RayCast2D = get_node("SplashCast")
@onready
var AlchemyEngine: Node = get_tree().get_first_node_in_group("Engines")

var ingredient: Ingredient




func _ready() -> void:
	get_viewport().get_camera_2d().connect("stage_changed", _stage_changed)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if dragging:
		position = get_viewport().get_camera_2d().position + get_viewport().get_mouse_position()
		ghost_layer.clear()
		ghost_layer.set_pattern(workplace.local_to_map(workplace.to_local(position)), ingredient.pattern)
		for used_cell in ghost_layer.get_used_cells():
			if used_cell in workplace.get_used_cells():
				ghost_layer.set_cell(used_cell,workplace_tileset.get_source_id(0),Vector2i(0,1))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and dragging:
		_drop()
		

func _drop():
	dragging = false;
	
	
	var can_place_pattern: bool = true
	var used_pattern = ingredient.pattern
	var dropped_position: Vector2i = workplace.local_to_map(workplace.to_local(position))
	for cell: Vector2i in used_pattern.get_used_cells():
		if workplace.get_used_cells().has(cell + dropped_position):
			can_place_pattern = false
			break
	if can_place_pattern:
		workplace.set_pattern(dropped_position, used_pattern)
		var pattern_positions = used_pattern.get_used_cells().duplicate()
		for index: int in pattern_positions.size():
			pattern_positions[index] += dropped_position
		pattern_positions = PackedVector2Array(pattern_positions)
		for cell in used_pattern.get_used_cells():
			AlchemyEngine.pattern_position_dict.get_or_add(cell + dropped_position,pattern_positions)
	
	ghost_layer.clear()
	_splash()
	queue_free()

func _offset_vector(v: Vector2, o: Vector2):
	v += o

func _splash():
	# Play wave / shockwave shader
	# Play water plop sound
	# Splash particles
	#if splash_cast.is_colliding():
	#AlchemyEngine.add_ingredient(self.ingredient) 
	pass

func _stage_changed(_where_to: Vector2i):
	queue_free()
