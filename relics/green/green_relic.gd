class_name GreenRelic extends Relic

const GREEN_RELIC_DATA = preload("uid://dqupr6bw5e16g")

func apply_effect(tower_buff: TowerBuff) -> void:
	tower_buff.attack_speed_mult -= 0.1

func get_data() -> RelicData:
	return GREEN_RELIC_DATA
