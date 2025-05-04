extends Node2D

const Illness = Classes.Illness

@onready
var GameManager: Node = get_tree().get_first_node_in_group("GameManager")

var envelope_instanceable: PackedScene = preload("res://src/instanceables/envelope/envelope.tscn")

@onready
var card_spawn_position: Vector2 = get_node("CardSpawnPosition").position # Out of bounds spawn position

@export_flags_2d_physics
var envelope_layer

var focused_envelope: CharacterBody2D # The envelope taht is in the center of the screen

func _ready() -> void:
	for i in 2:
		add_envelope(null)
		await get_tree().create_timer(1).timeout

func add_envelope(_illness: Illness): 
	var new_envelope = envelope_instanceable.instantiate()
	new_envelope.position = card_spawn_position
	new_envelope.scale = Vector2.ONE * 2.5
	add_child(new_envelope)
	
	var new_envelope_tween: Tween = create_tween()
	new_envelope_tween.set_trans(Tween.TRANS_SINE)
	new_envelope_tween.set_ease(Tween.EASE_OUT)
	new_envelope_tween.parallel().tween_property(new_envelope,"scale", Vector2.ONE, 1) # Give fake height
	new_envelope_tween.parallel().tween_property(new_envelope,"position", Vector2(get_viewport().size * 0.25), 1) # Move to center of screen
	new_envelope_tween.parallel().tween_property(new_envelope,"rotation_degrees", randf_range(0,359), 1) # Give random rotation so it's less linear

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and GameManager.current_stage == Vector2i.ZERO:
		var envelope: CharacterBody2D = await try_grab(event.position)
		if envelope: # We clicked an envelope
			if event.is_double_click():
				if not focused_envelope: # No envelope is focused rn
					focused_envelope = envelope
					envelope._show_envelope_contents() # show correspondence
				else:
					if envelope != focused_envelope: # Only do something when the envelope is new
						focused_envelope._hide_envelope_contents()
						focused_envelope = envelope
						envelope._show_envelope_contents()
			elif not envelope.focused:
				envelope.dragging = true
				envelope.offset = envelope.to_local(event.position)

func try_grab(pos: Vector2) -> CharacterBody2D:
	var grab_cast: RayCast2D = RayCast2D.new()
	grab_cast.collision_mask = envelope_layer # Set collision mask (What mask to search)
	grab_cast.hit_from_inside = true # So it hits colliders even if no walls were hit
	grab_cast.position = pos # Where to instantiate raycast
	grab_cast.target_position = Vector2.ZERO # Where to point to
	add_child(grab_cast) # Finalization of instantiation
	await get_tree().process_frame # Wait for a frame to check if there is any collision

	var grabbed_envelope : CharacterBody2D = null # If there is one, here we will save the envelope
	if grab_cast.is_colliding():
		grabbed_envelope = grab_cast.get_collider()
	grab_cast.queue_free() # Remove trailing raycast after usage
	return grabbed_envelope
