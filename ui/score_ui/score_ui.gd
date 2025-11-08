class_name ScoreUi extends Control

@export var enemy_generator: EnemyGenerator

@onready var amount_gold_label: Label = $VBoxContainer/AmountGoldLabel
@onready var next_wave_time: Label = $CenterContainer/VBoxContainer/NextWaveTime

func _ready():
	_on_gold_change(Score.gold)
	Score.gold_change.connect(_on_gold_change)
	
func _on_gold_change(amount: int) -> void:
	amount_gold_label.text = str(amount)
