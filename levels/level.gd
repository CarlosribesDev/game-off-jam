class_name Level extends Node2D

@onready var enemy_path: Path2D = $EnemyPath
@onready var musica_percu: AudioStreamPlayer = $MusicaPercu

func get_new_path_follow() -> PathFollow2D:
	var path_follow = PathFollow2D.new()
	enemy_path.add_child(path_follow)
	
	return path_follow
	
func _ready():
	musica_percu.play()
	
