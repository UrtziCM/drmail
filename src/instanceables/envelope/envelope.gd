extends CharacterBody2D

const Illness = Classes.Illness
const CardTextFabricator = preload("res://src/scenes/envelopes/card_text_fabricator.gd")

var dragging: bool
var offset: Vector2

var original_position: Vector2

var focused: bool = false

var illness: Illness = Illness.create_random_illness()
var opened: bool = false

var rotate_to_zero_tween: Tween

var panel: Control

signal card_focused(card: CharacterBody2D)
signal card_unfocused(card: CharacterBody2D)

func _process(_delta: float) -> void:
	if dragging: 
		if offset != Vector2.ZERO:
			offset = offset.move_toward(Vector2.ZERO, 5)
		if rotation_degrees != 0 and not rotate_to_zero_tween:
			rotate_to_zero_tween = create_tween()
			rotate_to_zero_tween.set_trans(Tween.TRANS_SINE)
			rotate_to_zero_tween.set_ease(Tween.EASE_OUT)
			rotate_to_zero_tween.tween_property(self,"rotation_degrees", 0, 0.75)
		position = get_global_mouse_position() - offset


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = false

func _show_envelope_contents():
	original_position = position
	opened = true
	
	var bring_to_front_tween: Tween = create_tween()
	bring_to_front_tween.set_trans(Tween.TRANS_SINE)
	bring_to_front_tween.set_ease(Tween.EASE_OUT)
	bring_to_front_tween.parallel().tween_property(self,"position",Vector2(get_viewport().size * 0.25),.5)
	bring_to_front_tween.parallel().tween_property(self,"scale",Vector2.ONE * 3,.5)
	
	focused = true
	
	await bring_to_front_tween.finished
	
	CardTextFabricator.create_card_panel(self)
	
	card_focused.emit(self)

func _hide_envelope_contents():
	var bring_to_front_tween: Tween = create_tween()
	bring_to_front_tween.set_trans(Tween.TRANS_SINE)
	bring_to_front_tween.set_ease(Tween.EASE_OUT)
	bring_to_front_tween.parallel().tween_property(self,"position",original_position,.5)
	bring_to_front_tween.parallel().tween_property(self,"scale",Vector2.ONE,.5)
	
	if panel:
		panel.queue_free()
	
	await bring_to_front_tween.finished
	
	focused = false
	card_unfocused.emit(self)

func _physics_process(delta: float) -> void:
	if not dragging and scale == (Vector2.ONE):
		move_and_slide()
	velocity = velocity.move_toward(Vector2.ZERO, 20)
