#EnemyGenerator.gd
extends Node

signal enemy_die(enemy: Enemy)
signal next_wave_time(seconds: int)

const ENEMY = preload("uid://diax8n45uy1cu")
var enemy_timer: Timer
var _level: Level
var waves_data: EnemyWavesData
var enemy_paths: EnemyPaths
var time_between_waves: int
var count = 0

#TIMERS
var next_wave_timer: Timer

@onready var enemy_spawn: Timer = $EnemySpawn

func set_level(level: Level) -> void:
	_level = level
	waves_data = level.get_waves_data()
	enemy_paths = level.get_enemy_paths()
	

func init() -> void:
	time_between_waves
	

func generate_enemies(level: Level) -> void:
	_level = level
	enemy_timer = Timer.new()
	enemy_timer.wait_time = 3
	enemy_timer.one_shot = false
	enemy_timer.timeout.connect(_on_enemy_timer)
	level.add_child(enemy_timer)
	enemy_timer.start()
	
func _on_enemy_timer() -> void:
	# 1. Instanciar el enemigo
	var new_enemy: Enemy = ENEMY.instantiate()
	new_enemy.die.connect(_on_enemy_die)
	get_tree().root.add_child(new_enemy)
	
	new_enemy.set_path_follow(_level.get_new_path_follow())
	count += 1

func _on_enemy_die(enemy: Enemy) -> void:
	enemy_die.emit(enemy)
	
