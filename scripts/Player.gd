class_name Player extends CharacterBody2D

#@onready var animation_tree: AnimationTree = $AnimationTree
#@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

var speed = 350
var last_direction = "right"  # Iniciar el personaje mirando hacia la derecha por defecto
var health: int = 100

func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed

	# Verificar si hay movimiento en el eje X (horizontal)
	if velocity.x != 0:
		if velocity.x > 0:
			#animation_state.travel("Walk-Right")  # Cambiar al estado de caminar a la derecha
			last_direction = "right"
		else:
			#animation_state.travel("Walk-Left")  # Cambiar al estado de caminar a la izquierda
			last_direction = "left"

	# Si no hay movimiento en el eje X, pero sí en el eje Y (vertical)
	#elif velocity.y != 0:
	#	if last_direction == "right":
			#animation_state.travel("Walk-Right")  # Caminar hacia la última dirección (derecha)
	#	else:
			#animation_state.travel("Walk-Left")  # Caminar hacia la última dirección (izquierda)

	# Si no hay movimiento en ningún eje, cambiar a la animación de Idle
	#else:
		#animation_state.travel("Idle-Down")  # Asume Idle mirando hacia abajo como default
	


	
func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
