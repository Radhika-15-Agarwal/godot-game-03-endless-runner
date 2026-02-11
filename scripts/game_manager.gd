extends Node

var is_game_over := false

var world_speed := 0.0
var score := 0.0
var high_score := 0

@export var score_factor = 0.05
@export var base_world_speed := 300.0
@export var speed_increase_rate := 6.0

signal score_changed(new_score)
signal game_over_changed(state)
signal high_score_changed(new_high_score)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	reset()

func _process(delta: float) -> void:
	if not is_game_over:
		score += world_speed * delta * score_factor
		world_speed += speed_increase_rate * delta
		score_changed.emit(score)

	if is_game_over and Input.is_action_just_pressed("restart"):
		restart()

func game_over():
	if is_game_over:
		return

	is_game_over = true
	game_over_changed.emit(true)
	
	get_tree().paused = true
	print("Game Over")
	
	if score > high_score:
		high_score = score
		high_score_changed.emit(high_score)

func restart():
	reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func reset():
	world_speed = base_world_speed
	score = 0
	is_game_over = false
	
