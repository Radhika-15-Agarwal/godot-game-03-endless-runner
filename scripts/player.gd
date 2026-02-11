extends CharacterBody2D

@export var gravity := 1200.0
@export var fall_multiplier := 1.3

@export var jump_velocity := -500.0
@export var jump_buffer_time := 0.1

var jump_buffer_timer := 0.0

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	
	velocity.x = 0
	
	# Gravity
	if not is_on_floor():
		if velocity.y > 0:
			# Falling
			velocity.y += gravity * fall_multiplier * delta
		else:
			# Rising
			velocity.y += gravity * delta
	
	#jump buffer 
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	# Jump
	if jump_buffer_timer > 0 and is_on_floor():
		velocity.y = jump_velocity
		jump_buffer_timer = 0
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("obstacle"):
			GameManager.game_over()
