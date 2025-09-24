extends Node2D

@onready var target = $Player/tilePlacement
@onready var tile_map = get_node("TileMapLayer")
@onready var player = get_node("Player")

func _ready():
	new_game()
	#generate()
	
func new_game():
	$Player.show()
	#target.global_position = tile_map.map_to_local(Vector2i(player.global_position.x + 1, player.global_position.y))
	$TileMapLayer.show()
