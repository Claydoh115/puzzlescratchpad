extends TileMapLayer

@onready var player = $"../Player"
@onready var placementarea = $"../Player/tilePlacement"
func _on_player_generate_tiles() -> void:
	generate()


func _on_player_place_tile() -> void:
	var rng = RandomNumberGenerator.new()
	var patternIndex = rng.randf_range(1, 13)
	var pattern = tile_set.get_pattern(patternIndex)
	#var pattern = tile_set.get_pattern(14)
	var position = Vector2i()
	var current_tile: Vector2i = local_to_map(placementarea.global_position)
	print(current_tile)
	print(player.position)
	var tile_data: TileData = get_cell_tile_data(current_tile)
	#print(player.position)
	#position = tilemap_layer.local_to_map(player.global_position) #TODO player position gets off when moving diagonally? can I correct and can I snap to ints?
	#position = player.position
	var x = current_tile.x
	var y = current_tile.y
	#print (x)
	#print(y)
	if tile_data.get_custom_data("isCorner") == true:
		set_pattern(Vector2i(x, y), pattern) # the -1 takes into account the center of the tile i think?
	else: 
		var corner_tile = find_corner(current_tile)
		set_pattern(Vector2i(corner_tile.x, corner_tile.y), pattern)
	#tilemap_layer.set_pattern(Vector2i(player.position.x, player.position.y), pattern)
	
	
func generate():
	var x = -13
	var y = -2
	for i in range(1, 10):
		for j in range(1, 10):
			var rng = RandomNumberGenerator.new()
			var patternIndex = rng.randf_range(1, 13)
			var win: int = rng.randf_range(1, 100)
			if win == 67:
				patternIndex = 15
			var pattern = tile_set.get_pattern(patternIndex)
			set_pattern(Vector2i(x, y), pattern)
			x -= 4
		y += 4
		x = -13
		
func find_corner(tile):
	# because top left corner is what we need I should only need to look up and left
	var x = tile.x
	var y = tile.y
	for i in range (0, 4):
		for j in range(0, 4):
			var new_tile = get_cell_tile_data(Vector2i(x, y))
			if new_tile.get_custom_data("isCorner") == true:
				return Vector2i(x, y)
			x -= 1
			print(x)
		x = tile.x
		print()
		y -= 1
				
	
