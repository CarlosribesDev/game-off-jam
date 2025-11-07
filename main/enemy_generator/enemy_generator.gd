class_name EnemyGenerator extends Node

signal enemy_die(enemy: Enemy)
const ENEMY = preload("uid://diax8n45uy1cu")

var _level: Level
var count = 0

@onready var enemy_spawn: Timer = $EnemySpawn

func generate_enemies(level: Level) -> void:
	_level = level
	enemy_spawn.start()
	
func _on_enemy_spawn_timeout() -> void:
	var new_enemy: Enemy = ENEMY.instantiate()
	new_enemy.die.connect(_on_enemy_die)
	get_tree().root.add_child(new_enemy)
	
	new_enemy.set_path_follow(_level.get_new_path_follow())
	count += 1
	
func _on_enemy_die(enemy: Enemy) -> void:
	enemy_die.emit(enemy)
	
