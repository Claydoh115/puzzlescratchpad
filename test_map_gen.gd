extends TileMapLayer

func _ready():
	generate()

func generate():
	var rng = RandomNumberGenerator.new()
	var patternIndex = rng.randf_range(0, 3)
	$testMapGen.set_cell(Vector2i(0, 0), 0, Vector2i(27, 2))
