@tool
class_name RedProjectil extends Node2D

@export var cast_speed: int = 7000
@export var color: Color = Color.RED: set = set_color
@export var damage: float = 5
@export var growth_time: float = 0.1


var _target: Enemy 

var tween: Tween = null
var current_laser_length: float = 0.0
var is_casting: bool = false

@onready var line_2d: Line2D = $Line2D
@onready var line_width: float = line_2d.width

func _ready():
	set_color(color)

func _physics_process(delta: float) -> void:
	if not is_casting or not _target:
		return
		
	# --- STEP 1: rotate the laser beam towards the target ---
	look_at(_target.global_position)

	# --- PASO 2: The laser's length is modified depending on the enemy's position; 
	# --- the speed at which the laser changes length depends on cast_speed. ---
	var distance_to_target = global_position.distance_to(_target.global_position)
	
	current_laser_length = move_toward(
		current_laser_length,
		distance_to_target,
		cast_speed * delta
	)
	
	line_2d.points[1] = Vector2(current_laser_length, 0.0)

func stop() -> void:
	_target = null
	_set_is_casting(false)

func set_target(target: Enemy) -> void:
	if target == _target:
		return	
	
	_target = target
	
	if not is_casting:
		_set_is_casting(true)
		
func hit_target() -> void:
	if not _target:
		return
	_target.get_damage(damage)

func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d:
		line_2d.modulate = new_color

func _set_is_casting(new_value: bool) -> void:
	if is_casting == new_value:
		return
		
	is_casting = new_value
	
	if is_casting == false:
		_dissapear()
	else:
		current_laser_length = 0.0
		_appear()

func _dissapear() -> void:
	if not line_2d:
		return
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween()
	# Animación de ancho a cero
	tween.tween_property(line_2d, "width", 0.0, growth_time * 2.0).from_current()
	# Opcional: Ocultar el nodo y reiniciar la longitud después de la animación
	tween.tween_callback(line_2d.hide)
	tween.tween_callback(func(): current_laser_length = 0.0)
	
func _appear() -> void:
	if not line_2d:
		return
	line_2d.visible = true
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween()
	# Animación de ancho de cero a ancho original
	tween.tween_property(line_2d, "width", line_width, growth_time * 2.0).from(0.0)
	
	
