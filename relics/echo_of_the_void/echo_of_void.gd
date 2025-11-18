class_name EchoOfVoid extends Relic

const ECHO_OF_THE_VOID_DATA = preload("uid://bqxxbovbmgaho")

func apply_effect(tower_buff: TowerBuff) -> void:
	var green_tower_buffs = tower_buff as GreenTowerBuff
	green_tower_buffs.extra_waves += 1

func get_data() -> RelicData:
	return ECHO_OF_THE_VOID_DATA
