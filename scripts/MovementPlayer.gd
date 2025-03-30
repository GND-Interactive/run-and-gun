extends CharacterBody2D

var speed = 300
var acceleration = 2000
var player_alive = true

func _physics_process(delta: float) -> void:
	print(velocity)
	
	# Movimiento
	var move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(move_input)
	
	velocity.x = move_toward(velocity.x, move_input.x * speed, acceleration * delta)
	velocity.y = move_toward(velocity.y, move_input.y * speed, acceleration * delta)

	# Movimiento físico
	move_and_slide()
