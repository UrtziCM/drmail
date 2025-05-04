extends CharacterBody2D

@onready
var resting_position = position

var picked_up: bool = false

var pickable: bool = true

var move_to_resting_tween: Tween

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed() and picked_up:
		_let_go()

func _on_spoon_click(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and pickable:
		_pick_up()


func _process(_delta: float) -> void:
	if picked_up:
		position = get_viewport().get_mouse_position()

func _pick_up():
	if move_to_resting_tween and move_to_resting_tween.is_running():
		move_to_resting_tween.kill()
	picked_up = true

func _let_go():
	picked_up = false
	_send_to_resting()

func _send_to_resting():
	move_to_resting_tween = create_tween()
	move_to_resting_tween.set_trans(Tween.TRANS_EXPO)
	move_to_resting_tween.set_ease(Tween.EASE_OUT)
	move_to_resting_tween.parallel().tween_property(self, "position", resting_position, 1)
	move_to_resting_tween.tween_callback(self.set.bind("pickable", true))
	await move_to_resting_tween.finished
