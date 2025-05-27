extends Camera2D

const unscaled_viewport_width = 640
const unscaled_viewport_height = 360

var movement_animation_duration: float

var stages: Dictionary[String,Vector2i]
var current_stage_position: Vector2i

signal stage_changed(stage: Vector2i)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var target_dir: Vector2i = Vector2i.ZERO
		if event.is_action("MoveCameraRight"):
			target_dir = Vector2i.RIGHT
		elif event.is_action("MoveCameraLeft"):
			target_dir = Vector2i.LEFT
		elif event.is_action("MoveCameraUp"):
			target_dir = Vector2i.UP
		elif event.is_action("MoveCameraDown"):
			target_dir = Vector2i.DOWN
		else:
			return
		
		
		if _can_go_direction(target_dir): # If there is something that direction, go ahead
			current_stage_position += target_dir
			move_to_stage_pos(current_stage_position)


func _can_go_direction(dir: Vector2i):
	return stages.values().has(current_stage_position + dir) # returns true if there is something in that position in our "map" 

func move_to_stage_pos(target_pos: Vector2i):
	var stage_movement_tween: Tween = create_tween()
	stage_movement_tween.set_ease(Tween.EASE_OUT)
	stage_movement_tween.set_trans(Tween.TRANS_BACK)
	
	# Move to the target position using the viewport height and width (For future resolution scaling I guess)
	stage_movement_tween.tween_property(self,"position",Vector2(unscaled_viewport_width, unscaled_viewport_height) * Vector2(target_pos), movement_animation_duration)
	emit_signal("stage_changed", current_stage_position)
	await stage_movement_tween.finished

func move_to_stage_name(target_name: String): 
	var target_pos = stages[target_name]
	move_to_stage_pos(target_pos)

func add_stage(stage_name: String, pos: Vector2i):
	stages[stage_name] = pos
