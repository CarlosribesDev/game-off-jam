#TowerUpgrades
extends Node

signal tower_stats_change(tower_type: Tower.TowerType, new_stats: TowerStats)

const REWARDS_UI = preload("uid://bcxsfb0ox3gmq")
# base stats
const RED_TOWER_BASE_STATS: TowerStatsBase = preload("uid://bndxfmba1ltf8")
const GREEN_TOWER_BASE_STATS: TowerStatsBase = preload("uid://c1d3qqqdi2oxp")
const BLUE_TOWER_BASE_STATS: TowerStatsBase = preload("uid://by0giydu700gy")
const TOWER_BASE_STATS = {
	Tower.TowerType.RED: RED_TOWER_BASE_STATS,
	Tower.TowerType.GREEN: GREEN_TOWER_BASE_STATS,
	Tower.TowerType.BLUE: BLUE_TOWER_BASE_STATS,
}

const AMOUNT_TO_REWARD_1 = 2
const AMOUNT_TO_REWARD_2 = 4
const AMOUNT_TO_REWARD_3 = 6
const AMOUNT_TO_REWARD_4 = 8

var rewards: Array[Relic] = [RedRelic.new()]

# current stats
var towers_stats = {
	Tower.TowerType.RED: TowerStats.new(),
	Tower.TowerType.GREEN: TowerStats.new(),
	Tower.TowerType.BLUE: TowerStats.new(),
}

func _ready() -> void:
	_init_stats()	

func reset_stats() -> void:
	_init_stats()

func on_tower_placed(tower_type: Tower.TowerType, amount: int) -> void:
	match tower_type:
		Tower.TowerType.RED: _handle_red_updates(amount)
		Tower.TowerType.GREEN: _handle_green_updates(amount)
		Tower.TowerType.BLUE: _handle_blue_updates(amount)

func get_stats(tower_type: Tower.TowerType) -> TowerStats:
	return towers_stats[tower_type]

func _init_stats() -> void:
	for tower_type in Tower.TowerType.values():
		var base_stats = TOWER_BASE_STATS[tower_type]
		get_stats(tower_type).init_stats_base(base_stats)
		tower_stats_change.emit(tower_type, get_stats(tower_type))
		
func _handle_red_updates(amount: int) -> void:
	match amount:
		AMOUNT_TO_REWARD_1: _add_red_relic()
		AMOUNT_TO_REWARD_2: _add_red_relic()
		AMOUNT_TO_REWARD_3: _add_red_relic()
		AMOUNT_TO_REWARD_4: _add_red_relic()
	
func _handle_green_updates(amount: int) -> void:
	match amount:
		AMOUNT_TO_REWARD_1: _add_green_relic()
		AMOUNT_TO_REWARD_2: _add_green_relic()
		AMOUNT_TO_REWARD_3: _add_green_relic()
		AMOUNT_TO_REWARD_4: _add_green_relic()
	
func _handle_blue_updates(amount: int) -> void:
	match amount:
		AMOUNT_TO_REWARD_1: _add_blue_relic()
		AMOUNT_TO_REWARD_2: _add_blue_relic()
		AMOUNT_TO_REWARD_3: _add_blue_relic()
		AMOUNT_TO_REWARD_4: _add_blue_relic()
	
func _add_red_relic() -> void:
	var rewards_ui: RewardsUI = REWARDS_UI.instantiate()
	var canvas = get_tree().root.get_node("Game").get_node("RewardsLayer")
	canvas.add_child(rewards_ui)
	rewards_ui.set_relics(rewards)
	#RelicsManager.add_red_relic(towers_stats)
	#_emit_all_status_change()

func _add_green_relic() -> void:
	RelicsManager.add_green_relic(towers_stats)
	_emit_all_status_change()

func _add_blue_relic() -> void:
	RelicsManager.add_blue_relic(towers_stats)
	_emit_all_status_change()

func _emit_all_status_change() -> void:
	for tower_type in Tower.TowerType.values():
		tower_stats_change.emit(tower_type, get_stats(tower_type))
	
