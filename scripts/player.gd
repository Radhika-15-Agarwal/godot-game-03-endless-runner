extends CharacterBody2D


@export var run_speed := 300.0
@export var jump_velocity := -500.0
@export var gravity := 1200.0

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	
	velocity.x = 0
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("obstacle"):
			GameManager.game_over()
