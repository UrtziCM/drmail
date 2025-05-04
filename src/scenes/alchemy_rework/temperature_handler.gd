extends Node

const MAX_FIRE_SCALE: float = 2
const MIN_FIRE_SCALE: float = 1.25


@export
var temp_slider: VSlider
@export
var fire_sprite: Sprite2D

var temperature: float

func _temperature_slider_value_changed(value: float) -> void:
	temperature = value
	tween_fire_sprite_scale()

func _normalized_slider_value():
	return temp_slider.value / temp_slider.max_value

func tween_fire_sprite_scale():
	var temp_scale_tween: Tween = create_tween()
	temp_scale_tween.parallel().tween_property(fire_sprite, "scale",Vector2(2,2) * _normalized_slider_value(), 1)
