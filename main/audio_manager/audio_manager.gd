extends Node2D

signal tempo

func play_coins():
	$coins.play()

func _on_tempo_timeout() -> void:
	tempo.emit()
