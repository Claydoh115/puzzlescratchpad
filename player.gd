extends CharacterBody2D
signal placeTile
signal generateTiles
signal toggle_pause

@onready var tile_map = $"../TileMapLayer"
@onready var ray_cast = get_node("RayCast2D")
@onready var sprite = get_node("Sprite2D2")
@onready var target = get_node("tilePlacement")
@onready var label = $"../Label"
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window
var isMoving = false
var walkSpeed = false

func _ready():
	screen_size = get_viewport_rect().size
	target.play("default")
	hide()
	
func _process(delta):
	if isMoving == true:
		return
	if walkSpeed:
		if Input.is_action_pressed("move_right"):
			move(Vector2.RIGHT)
		elif Input.is_action_pressed("move_left"):
			move(Vector2.LEFT)
		elif Input.is_action_pressed("move_down"):
			move(Vector2.DOWN)
		elif Input.is_action_pressed("move_up"):
			move(Vector2.UP)
	else:	
		if Input.is_action_just_pressed("move_right"):
			move(Vector2.RIGHT)
		elif Input.is_action_just_pressed("move_left"):
			move(Vector2.LEFT)
		elif Input.is_action_just_pressed("move_down"):
			move(Vector2.DOWN)
		elif Input.is_action_just_pressed("move_up"):
			move(Vector2.UP)

	
func move(direction: Vector2):
		var current_tile: Vector2i = tile_map.local_to_map(global_position)
		var target_tile: Vector2i = Vector2i(current_tile.x + direction.x, current_tile.y + direction.y)
		var tile_data: TileData = tile_map.get_cell_tile_data(target_tile)
		if tile_data == null:
			return
		if tile_data.get_custom_data("Walkable") == false:
			return
		#global_position = tile_map.map_to_local(target_tile)
		
		ray_cast.target_position = direction * 16
		ray_cast.force_raycast_update()
		
		if ray_cast.is_colliding():
			return
		
		isMoving = true
		global_position = tile_map.map_to_local(target_tile)
		sprite.global_position = tile_map.map_to_local(current_tile)
		target.global_position = tile_map.map_to_local(Vector2i(target_tile.x + direction.x, target_tile.y + direction.y))
		if tile_data.get_custom_data("isWin"):
			label.text = "WIN!!!"

func _physics_process(delta: float) -> void:
	if isMoving == false:
		return
	if global_position == sprite.global_position:
		isMoving = false
		return
	sprite.global_position = global_position.move_toward(global_position, 1)

func _input(event):
	if event.is_action_pressed("place_tile"):
		emit_signal("placeTile")
	if event.is_action_pressed("generate_tiles"):
		emit_signal("generateTiles")
	if event.is_action_pressed("toggle_speed"):
		walkSpeed = !walkSpeed
	if event.is_action_pressed("toggle_pause"):
		emit_signal("toggle_pause")

func start(pos):
	# position = pos
	show()
	target.global_position = tile_map.local_to_map(Vector2i(global_position.x + 1, global_position.y))
	$CollisionShape2D.disabled = false
