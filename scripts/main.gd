extends Node2D

@onready var ground = $Ground
@onready var player = $Player

func _ready():
	position_ground()
	position_player()

func position_ground():
	var screen_height = get_viewport_rect().size.y
	
	var ground_height = ground.get_node("CollisionShape2D").shape.size.y
	var half_height = ground_height / 2.0
	
	ground.position.y = screen_height - half_height

func position_player():
	var ground_shape = ground.get_node("CollisionShape2D").shape
	var ground_top = ground.position.y - ground_shape.size.y / 2.0
	
	var player_shape = player.get_node("CollisionShape2D").shape
	var player_half_height = player_shape.size.y / 2.0
	
	player.position.y = ground_top - player_half_height
	player.position.x = 200  # fixed runner position
