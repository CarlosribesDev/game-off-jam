class_name DeathScene extends CanvasLayer


func _ready() -> void:
	get_tree().paused = true

func _on_try_again_button_pressed() -> void:
	get_tree().paused = false
	var game: Game = get_tree().root.get_node("Game")
	game.reset_current_level()
	queue_free()
