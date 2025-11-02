class_name TowerPlacer extends Node2D

@onready var towers_menu: TowersMenu = $"../GameUI/TowersMenu"
@onready var test_level: Level = $"../Level/TestLevel"

var tile_map: TileMapLayer
var _is_placing = false
var _current_tower_instance: Tower = null

# state
var _is_valid_placement = false
var _snapped_world_position: Vector2 = Vector2.ZERO

func _ready():
	towers_menu.tower_selected.connect(_on_tower_selected)
	await test_level.ready
	tile_map = test_level.get_tile_map()
	
func _process(_delta: float) -> void:
	if not _is_placing or not is_instance_valid(_current_tower_instance):
		return
		# Mueve la instancia de la torreta a la posición del ratón
	var mouse_pos = get_global_mouse_position()
	# 1. Obtener coordenadas del tile bajo el ratón
	var map_coords = tile_map.local_to_map(tile_map.to_local(mouse_pos))
	var tile_data = tile_map.get_cell_tile_data(map_coords)
	
	if tile_data != null:
		# check_tile
		if tile_data.get_custom_data("buildeable"):
			_is_valid_placement = true
			
			# get_tile_pos 
			var center_pos_local = tile_map.map_to_local(map_coords)
			
			
			_snapped_world_position = tile_map.to_global(center_pos_local)
			_current_tower_instance.global_position = _snapped_world_position
		else:
			_current_tower_instance.global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	# Detectar clic izquierdo
	if _is_placing and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		if _is_valid_placement:
			# 1. El snap de posición ya se hizo en _process, solo falta fijarla
			
			# 2. Opcional: Marcar el tile como NO buildeable para evitar construir encima de la torre
			var map_coords = tile_map.local_to_map(tile_map.to_local(get_global_mouse_position()))
			#tile_map.set_cell_custom_data(0, map_coords, "buildeable", false)
			
			# 3. Finalizar la colocación
			_is_placing = false
			_current_tower_instance = null
			#get_tree().set_input_as_handled()

func _on_tower_selected(tower_scene: PackedScene) -> void:
	if _is_placing:
		return
	
	_current_tower_instance = tower_scene.instantiate()
	add_child(_current_tower_instance)
	_is_placing = true
	
	
