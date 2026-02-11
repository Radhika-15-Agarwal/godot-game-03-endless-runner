extends CharacterBody2D


func _physics_process(delta):
	if GameManager.is_game_over:
		return
	
	velocity.x = -GameManager.world_speed
	move_and_slide()
	
	if global_position.x < -200:
		queue_free()
