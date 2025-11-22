#TowerCounterManager
extends Node

signal tower_placed(tower_type: Tower.TowerType, amount: int)
signal tower_selected(tower: Tower)

var towers_placed: Dictionary[Tower.TowerType, int] = {
	Tower.TowerType.RED: 0,
	Tower.TowerType.BLUE: 0,
	Tower.TowerType.GREEN: 0
}

var current_tower_selected: Tower

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			clear_tower_selected()
			
func reset_towers_count() -> void:
	_update_tower_count(Tower.TowerType.RED, 0)
	_update_tower_count(Tower.TowerType.GREEN, 0)
	_update_tower_count(Tower.TowerType.BLUE, 0)

func clear_tower_selected() -> void:
	current_tower_selected = null
	tower_selected.emit(current_tower_selected)

# called from tower_placer to inform
func tower_added(tower: Tower) -> void:
	_update_tower_count(tower.type, towers_placed[tower.type] + 1)
	tower.selected.connect(_on_tower_selected)
	tower.stats_change.connect(_on_tower_stats_change)
	
func _update_tower_count(tower_type: Tower.TowerType, value: int) -> void:
	towers_placed[tower_type] = value
	tower_placed.emit(tower_type, value)
	
func _on_tower_selected(tower: Tower) -> void:
	current_tower_selected = tower
	tower_selected.emit(tower)

func _on_tower_stats_change(tower: Tower) -> void:
	if tower == current_tower_selected:
		tower_selected.emit(tower)
	
