extends CharacterBody2D



var speed = 300
var acceleration = 2000
var player_alive = true


func _physics_process(delta:float) -> void:
	print(velocity)
	# Gravity 

	
		# Movement Input	
	var move_input = Input.get_axis("moved_left","move_right")
	print(move_input)
	velocity.x = move_toward(velocity.x,move_input*speed,acceleration*delta)
		# Animation Movement

	move_and_slide()
