class_name Tower extends Node2D

@export var build_price: Price.TowerBuild = Price.TowerBuild.RED

const PROJECTIL = preload("uid://dipmywfwdmrlo")

var _targets_in_range: Array[Enemy] = [] 
var _current_target: Enemy
var _enabled: bool = false

@onready var projectile_spawn_pos: Marker2D = $ProjectileSpawnPos
@onready var red_projectil: RedProjectil = $RedProjectil
@onready var range_area: Area2D = $RangeArea

func _ready():
	range_area.monitoring = false
	
func _process(_delta: float) -> void:
	if not _current_target:
		red_projectil.stop()
		return
	red_projectil.set_target(_current_target)

# Enables the tower after its construction/placement.
# It is initially disabled to prevent actions while the player is placing it.
func enable() -> void:
	_enabled = true
	range_area.monitoring = true

func _on_range_area_body_entered(body: Node2D) -> void:
	if not _enabled:
		return
	var enemy = body as Enemy
	enemy.die.connect(_on_enemy_die)
	
	_targets_in_range.append(enemy)
	if _current_target == null:
		_current_target = enemy

func _on_range_area_body_exited(body: Node2D) -> void:
	var enemy = body as Enemy
	_remove_target_and_get_next(enemy)

func _on_enemy_die(enemy: Enemy) -> void:
	_remove_target_and_get_next(enemy)

func _remove_target_and_get_next(enemy: Enemy) -> void:
	# disconnect signal
	if enemy.die.is_connected(_on_enemy_die):
		enemy.die.disconnect(_on_enemy_die)
	# remove enemy
	_targets_in_range.erase(enemy)
	#exit when enemy is not the target
	if enemy != _current_target:
		return
	if _targets_in_range.is_empty():
		red_projectil.stop()
		_current_target = null
	else:
		#logic to select next target
		_current_target = _targets_in_range[0]

func _on_attack_timer_timeout() -> void:
	if _current_target == null or not _enabled:
		return
	
	red_projectil.hit_target()
