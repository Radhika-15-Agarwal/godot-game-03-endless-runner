extends Node2D

@export var obstacle_scene: PackedScene
@export var spawn_interval := 1.5

var timer := 0.0

func _process(delta):
	timer += delta
	
	if timer >= spawn_interval:
		spawn_obstacle()
		timer = 0.0

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	get_tree().current_scene.add_child(obstacle)
	
	var screen_width = get_viewport_rect().size.x
	
	obstacle.global_position.x = screen_width + 100
	
	var ground = get_tree().get_first_node_in_group("ground")
	var ground_shape = ground.get_node("CollisionShape2D").shape
	var ground_top = ground.position.y - ground_shape.size.y / 2.0
	
	var obstacle_shape = obstacle.get_node("CollisionShape2D").shape
	var obstacle_half_height = obstacle_shape.size.y / 2.0
	
	obstacle.global_position.y = ground_top - obstacle_half_height
