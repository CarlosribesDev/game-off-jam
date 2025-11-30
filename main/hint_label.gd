class_name HintLabel extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""
	TowerPlacementManager.tower_selected.connect(_on_tower_selected)
	TowerPlacementManager.tower_placing.connect(_on_tower_placing)

func _on_tower_placing(value: bool) -> void:
	if not value:
		text = ""
	else:
		# Indica claramente la acción y la tecla
		text = "[ESC] Cancel"

func _on_tower_selected(tower: Tower) -> void:
	if not tower:
		text = ""
	else:
		text = "[Right Click] Unselect"
	
