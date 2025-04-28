extends Node2D

@onready var camera: Camera2D = $"."
@onready var players_node: Node2D = $"../Players"

# Players 
var player_1: CharacterBody2D 
var player_2: CharacterBody2D

# Camera limits
var max_distance = 700  # distancia máxima permitida

func _process(delta):
	if not player_1 or not player_2:
		# Intentamos capturar los jugadores si todavía no los tenemos
		var players = players_node.get_children()
		if players.size() >= 2:
			player_1 = players[0]
			player_2 = players[1]
			print("Jugadores encontrados correctamente.")
		else:
			return  # Todavía no hay dos jugadores, no hacemos nada
			
	# Una ves tenemos a ambos jugadores
	print("players inicializados")
	var current_distance = abs(player_1.global_position.x - player_2.global_position.x)
	# El movimiento solo deberia detenerse cuando intentan alejarse, se deberia permitir cuando intentan acercarse
	if current_distance > max_distance:
		player_1.stop_movement()
		player_2.stop_movement()
	move_camera()

func move_camera():
	var distance_x = abs(player_1.global_position.x - player_2.global_position.x)
	if distance_x > max_distance:
		# Que hacer cuando la distancia es muy grande? 
		return
	
	else:
		var midpoint_x = (player_1.global_position.x + player_2.global_position.x) / 2
		camera.global_position.x = midpoint_x
	
	
	
