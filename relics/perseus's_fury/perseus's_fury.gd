class_name PerseusFury extends Relic

const PERSEUS_S_FURY_DATA = preload("uid://d3sm1lct1grwo")

func apply_effect(tower_buff: TowerBuff) -> void:
	var red_tower_buffs = tower_buff as RedTowerBuff
	red_tower_buffs.extra_execute_threshold += 5

func get_data() -> RelicData:
	return PERSEUS_S_FURY_DATA
