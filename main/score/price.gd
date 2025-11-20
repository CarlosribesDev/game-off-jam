#price.gd
extends Node

signal tower_price_change(tower_type: Tower.TowerType, price: int)
const price_increase_percent: float = 0.20

enum TowerBuild {
	RED = 50,
	GREEN = 90,
	BLUE = 70,
}

var red_tower_price: int = TowerBuild.RED
var green_tower_price: int = TowerBuild.GREEN
var blue_tower_price: int = TowerBuild.BLUE
var _last_red_tower_price: int = TowerBuild.RED
var _last_green_tower_price: int = TowerBuild.GREEN
var _last_blue_tower_price: int = TowerBuild.BLUE
var _free_towers_available = 0

func _ready() -> void:
	TowerPlacementManager.tower_placed.connect(_on_tower_placed)

func add_free_tower(amount: int = 1) -> void:
	if _free_towers_available == 0:
		_last_red_tower_price = red_tower_price
		_last_green_tower_price = green_tower_price
		_last_blue_tower_price = blue_tower_price
		red_tower_price = 0
		green_tower_price = 0
		blue_tower_price = 0
		_emit_all_towers_change()
	
	_free_towers_available += amount

func _on_tower_placed(tower_type: Tower.TowerType, amount: int) -> void:
	if _are_free_towers_avaible():
		return
	
	var base_price: int

	match tower_type:
		Tower.TowerType.RED:
			base_price = TowerBuild.RED
		Tower.TowerType.GREEN:
			base_price = TowerBuild.GREEN
		Tower.TowerType.BLUE:
			base_price = TowerBuild.BLUE		
		_:
			push_error("[Price.gd] Invalid tower type")
			return
	
	# calculate new price
	var increase_amount = float(base_price) * price_increase_percent * float(amount)
	var new_price = base_price + roundi(increase_amount)
	
	# update and emit new price
	match tower_type:
		Tower.TowerType.RED:
			red_tower_price = new_price
		Tower.TowerType.GREEN:
			green_tower_price = new_price
		Tower.TowerType.BLUE:
			blue_tower_price = new_price

	tower_price_change.emit(tower_type, new_price)

func get_price(tower_type: Tower.TowerType) -> int:
	match tower_type:
		Tower.TowerType.RED: return red_tower_price
		Tower.TowerType.GREEN: return green_tower_price
		Tower.TowerType.BLUE: return blue_tower_price
	
	push_error("[Price.gd] Invalid tower type")
	return 0

# handle free towers counter and indicates if prices must be increased
func _are_free_towers_avaible() -> bool:
	if _free_towers_available == 0:
		return false
	
	_free_towers_available -= 1
	
	# if no free towers avaible set last values again
	if _free_towers_available == 0:
		red_tower_price = _last_red_tower_price
		green_tower_price = _last_green_tower_price
		blue_tower_price = _last_blue_tower_price
		_emit_all_towers_change()
	return true
	
func _emit_all_towers_change() -> void:
	tower_price_change.emit(Tower.TowerType.RED, red_tower_price)
	tower_price_change.emit(Tower.TowerType.GREEN, green_tower_price)
	tower_price_change.emit(Tower.TowerType.BLUE, blue_tower_price)
