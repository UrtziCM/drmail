extends CharacterBody2D

const Illness = Classes.Illness
const CardTextFabricator = preload("res://src/scenes/envelopes/card_text_fabricator.gd")

var dragging: bool
var offset: Vector2

var original_position: Vector2

var focused: bool = false

var illness: Illness = Illness.create_random_illness()
var opened: bool = false

var envelope_ready: bool = false

var panel: Control

var root_scene: Node2D

signal card_focused(card: CharacterBody2D)
signal card_unfocused(card: CharacterBody2D)

func _show_envelope_contents():
	if not envelope_ready: return
	
	original_position = position
	opened = true
	
	var bring_to_front_tween: Tween = create_tween()
	bring_to_front_tween.set_trans(Tween.TRANS_SINE)
	bring_to_front_tween.set_ease(Tween.EASE_OUT)
	bring_to_front_tween.parallel().tween_property(self,"position",Vector2(get_viewport().size.x * 0.4,get_viewport().size.y * 0.25),.5)
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
	
	focused = false
	
	await bring_to_front_tween.finished
	
	root_scene.focused_envelope = null
	card_unfocused.emit(self)
