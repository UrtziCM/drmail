extends CharacterBody2D

var dragging: bool
var offset: Vector2

var focused: bool = false

signal card_focused(card: CharacterBody2D)

func on_envelope_start_drag(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and not event.double_click and event.button_mask == MOUSE_BUTTON_LEFT:
		dragging = true
		offset = get_local_mouse_position()

func _process(delta: float) -> void:
	if dragging: 
		position = get_global_mouse_position() - offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = false

func _on_envelope_double_click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.double_click and event.button_mask == MOUSE_BUTTON_LEFT:
		_show_envelope_contents()

func _show_envelope_contents():
	focused = true
	card_focused.emit(self)
	
	var bring_to_front_tween: Tween = create_tween()
	bring_to_front_tween.set_trans(Tween.TRANS_SINE)
	bring_to_front_tween.set_ease(Tween.EASE_OUT)
	bring_to_front_tween.parallel().tween_property(self,"position",Vector2(get_viewport().size * 0.25),.5)
	bring_to_front_tween.parallel().tween_property(self,"scale",Vector2.ONE * 3,.5)
	
