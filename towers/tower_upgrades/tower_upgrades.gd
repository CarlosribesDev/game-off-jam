extends Node

@export var tower_placer: TowerPlacer

func _ready() -> void:
	tower_placer.towers_placed.connect(_on_tower_placed)

func _on_tower_placed(tower_type: Tower.TowerType, amount: int) -> void:
	pass
