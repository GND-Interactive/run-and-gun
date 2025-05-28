extends Node2D

@onready var camera: Camera2D = $"."
@onready var players_node: Node2D = $"../Players"

# Players 
var player_1: CharacterBody2D 
var player_2: CharacterBody2D

## Distancia máxima permitida entre jugadores
var MAX_DISTANCE = 1200  

func _process(delta):
	if not player_1 or not player_2:
		var players = players_node.get_children()
		if players.size() >= 2:
			player_1 = players[0]
			player_2 = players[1]
			print("Jugadores encontrados correctamente.")
		else:
			return
			
	# Una ves tenemos a ambos jugadores
	print("players inicializados")
	move_camera()
	var string_Debug = "Camera position: %s" %camera.position
	#Debug.log(string_Debug)

func move_camera():
	var distance_x = abs(player_1.global_position.x - player_2.global_position.x)

	if distance_x > MAX_DISTANCE:
		# Limitar movimiento solo si se están alejando demasiado
		player_1.limit_movement(player_2.global_position, MAX_DISTANCE)
		player_2.limit_movement(player_1.global_position, MAX_DISTANCE)
	else:
		# Restaurar aceleración si están dentro del rango permitido
		player_1.acceleration = 2000
		player_2.acceleration = 2000

		# Actualizar posición de la cámara al punto medio
		var midpoint_x = (player_1.global_position.x + player_2.global_position.x) / 2
		camera.global_position.x = midpoint_x

	
	
	
