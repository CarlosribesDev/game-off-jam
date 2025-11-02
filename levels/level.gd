class_name Level extends Node2D


@onready var enemy_path: Path2D = $EnemyPath
@onready var tile_map_layer: TileMapLayer = $TileMapLayer


func get_new_path_follow() -> PathFollow2D:
	var path_follow = PathFollow2D.new()
	enemy_path.add_child(path_follow)
	
	return path_follow
	
func get_tile_map() -> TileMapLayer:
	return tile_map_layer

func _ready():
	EnemyGenerator.generate_enemies(self)
	
