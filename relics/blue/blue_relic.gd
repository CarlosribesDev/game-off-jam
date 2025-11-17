class_name BlueRelic extends Relic

const MULT = 0.1
const BLUE_RELIC_DATA = preload("uid://davvdqevvhiyk")

func apply_effect(tower_buff: TowerBuff) -> void:
	tower_buff.attack_range_mult += 0.1

func get_data() -> RelicData:
	return BLUE_RELIC_DATA
