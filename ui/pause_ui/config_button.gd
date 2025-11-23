extends Control

signal config_pressed()


@export var pause : PackedScene

func _on_config_button_pressed() -> void:
	config_pressed.emit()
