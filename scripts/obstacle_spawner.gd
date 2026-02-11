extends Node2D

@export var obstacle_scene: PackedScene

@export var base_min_distance := 500.0
@export var base_max_distance := 900.0

@export var min_distance_limit := 350.0
var progression = GameManager.world_speed - GameManager.base_world_speed

var current_min_distance := 0.0
var current_max_distance := 0.0
var current_spawn_distance := 0.0
var distance_accumulated := 0.0


func _ready():
	randomize()
	reset()


func reset():
	current_min_distance = base_min_distance
	current_max_distance = base_max_distance
	distance_accumulated = 0.0
	set_new_spawn_distance()


func _process(delta):
	if GameManager.is_game_over:
		return
	
	# Accumulate distance based on world speed
	distance_accumulated += GameManager.world_speed * delta
	
	if distance_accumulated >= current_spawn_distance:
		spawn_obstacle()
		distance_accumulated = 0.0
		set_new_spawn_distance()
	
	
	current_min_distance = max(
		min_distance_limit,
		base_min_distance - progression * 0.2
	)
	
	current_max_distance = max(
		current_min_distance + 100.0,
		base_max_distance - progression * 0.2
	)


func set_new_spawn_distance():
	current_spawn_distance = randf_range(current_min_distance, current_max_distance)


func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	get_tree().current_scene.add_child(obstacle)

	var screen_width = get_viewport_rect().size.x
	obstacle.global_position.x = screen_width + 100

	# Align to ground
	var ground = get_tree().get_first_node_in_group("ground")
	if ground:
		var ground_shape = ground.get_node("CollisionShape2D").shape
		var ground_top = ground.position.y - ground_shape.size.y / 2.0

		var obstacle_shape = obstacle.get_node("CollisionShape2D").shape
		var obstacle_half_height = obstacle_shape.size.y / 2.0

		obstacle.global_position.y = ground_top - obstacle_half_height
