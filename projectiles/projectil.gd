class_name Projectil extends Area2D

@export var damage = 5
@export var speed = 400

var _direction: Vector2

func set_direction(dir: Vector2) -> void:
	_direction = dir
	# La flecha mirará hacia la dirección de su movimiento
	look_at(global_position + _direction)

func _ready():
	pass
	
func _process(delta: float) -> void:
	global_position += _direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	var enemy = body as Enemy
	enemy.get_damage(damage)
	
	queue_free()
