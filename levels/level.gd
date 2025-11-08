class_name Level extends Node2D

@export var waves_data: EnemyWavesData
@export var enemy_paths: EnemyPaths

func _ready():
	EnemyGenerator.generate_enemies(self)
	
func get_waves_data() -> EnemyWavesData:
	if waves_data == null:
		push_error("[Level]: waves data not assigned in %s" % [name])
	return waves_data

func get_enemy_paths() -> EnemyPaths:
	if enemy_paths == null:
		push_error("[Level]: enemy path not assigned in %s" % [name])
	return enemy_paths
