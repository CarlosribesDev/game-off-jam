class_name RedRelic extends Relic

const RED_RELIC_DATA = preload("uid://cj2bl454ksc7e")

func apply_effect(tower_buff: TowerBuff) -> void:
	tower_buff.damage_mult += 0.1

func get_data() -> RelicData:
	return RED_RELIC_DATA
