extends Control

signal config_pressed()

@export var pause : PackedScene

func _on_config_button_pressed() -> void:
	AudioManager.play_button_click()
	config_pressed.emit()

func _on_config_button_mouse_entered() -> void:
	AudioManager.play_button_hover()
