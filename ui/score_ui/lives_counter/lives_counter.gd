class_name LivesCounter extends Control

@onready var couner_label: Label = $VBoxContainer/CounerLabel

var lives: int:
	set(value):
		lives = value
		couner_label.text = str(value)
