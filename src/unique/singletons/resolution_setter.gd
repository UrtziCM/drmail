extends Node2D

func _ready() -> void:
	set_resolution(1280,720)
	

func set_resolution(x: int, y: int, display = DisplayServer.get_primary_screen()):
	DisplayServer.window_set_size(Vector2(x,y), display)
	var scr_size: Vector2i = DisplayServer.screen_get_size(DisplayServer.get_primary_screen())
	DisplayServer.window_set_position((scr_size - Vector2i(x,y)) / 2,display)
