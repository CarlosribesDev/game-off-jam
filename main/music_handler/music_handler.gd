class_name MusicHandler extends Node

const MAX_PLAYERS = 8

@export var tower_placer: TowerPlacer

@onready var red_players: Node = $RedPlayers
@onready var blue_players: Node = $BluePlayers
@onready var green_players: Node = $GreenPlayers

var towers_placed = {
	Tower.TowerType.RED: 0,
	Tower.TowerType.BLUE: 0,
	Tower.TowerType.GREEN: 0
}

var tower_players = {
	Tower.TowerType.RED: red_players,
	Tower.TowerType.BLUE: blue_players,
	Tower.TowerType.GREEN: green_players
}

func _ready() -> void:
	tower_placer.tower_placed.connect(_on_tower_placed)

func _on_tower_placed(tower_type: Tower.TowerType) -> void:
	if towers_placed[tower_type] == MAX_PLAYERS:
		return

	var player_list: Array[Node] = (tower_players[tower_type] as Node).get_children()
	var player: AudioStreamPlayer = player_list.get(towers_placed[tower_type])
	towers_placed[tower_type] += 1
	player.play()
	
