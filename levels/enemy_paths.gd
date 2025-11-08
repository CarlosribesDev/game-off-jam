class_name EnemyPaths extends Node2D

func get_new_path_follow(path_num: int) -> PathFollow2D:
	if path_num >= get_child_count():
		push_error("[EnemyPaths] invalidad path_num: %d , number of paths: %d" % [path_num, get_child_count()])
	
	var path_follow = PathFollow2D.new()
	var path = get_child(path_num)
	
	path.add_child(path_follow)
	
	return path_follow
