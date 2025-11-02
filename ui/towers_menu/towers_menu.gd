class_name TowersMenu extends Control

const RED_TOWER = preload("uid://d36t7geqp1sh")

func _ready():
	pass
	

func _on_red_tower_button_pressed() -> void:
	var tower = RED_TOWER.instantiate()
