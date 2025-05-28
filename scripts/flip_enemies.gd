extends PathFollow2D


var previous_position: Vector2
@onready var node_2d: Node2D = $Node2D

func _ready():
	previous_position = position
	
func _physics_process(delta):
	# Mueve a lo largo del path
	progress += 200 * delta  # o tu velocidad deseada

	var direction = position - previous_position

	# Detecta si se mueve a la izquierda o derecha
	var moving_left = direction.x < 0

	# Accede al sprite del enemigo
	var enemy_node = node_2d.get_children()  # ajusta al nombre correcto
	for enemies in enemy_node:
		var sprite = enemies.get_node("AnimatedSprite2D")
		sprite.flip_h = moving_left

	# Guarda la posición para el siguiente frame
	previous_position = position
