extends Node2D

#Este Script maneja los limites de cada nivel
@onready var enemies: Node2D = $"../Enemies"
@onready var right_limit: StaticBody2D = $"right-limit"
@onready var timer: Timer = $"../Timer"
@onready var camera: Camera2D = $"../Camera2D"
@onready var zone_2: Area2D = $Area2D
@onready var main: Node2D = $".."
@onready var timer_2: Timer = $"../Timer2"

var boss_spawned = false

@onready var marker_2d: Marker2D = $"../Marker2D"

## Escena del jefe
const BOSS = preload("res://scenes/boss.tscn")

## Indica la zona actual de la etapa en la que se encuentran los jugadores
var current_zone : String = 'Zone-1'

## Indica que tanto se movera el limite derecho del juego
var CHANGE_STAGE_OFFSET: float = 500

func _ready():
	pass
	
## Mueve el limite derecho a la siguiente stage
## Genera un desplazamiento a la derecha del limite derecho
func move_right_limit() -> void:
	right_limit.position.x += CHANGE_STAGE_OFFSET
	return

## Retorna la cantidad de enemigos en la escena
func get_alive_enemies_count() -> int:
	return enemies.get_child_count()

func _process(delta: float) -> void:
	pass


## Bloquea la camara
## Crea la primera oleada de enemigos en la zona 2
## Cambia la current_zone a Zone-2
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is not CharacterBody2D:
		return
		
	# Aqui instanciamos los enemigos
	var cantidad_enemigos = 3
	var colores_enemigos_1 : Array[String]= ["red","red","red"]
	var colores_enemigos_2 : Array[String]=  ["blue","blue","blue"]
	var posicion_enemigos_1 = Vector2(1700,600)
	var posicion_enemigos_2 = Vector2(1700,400)
	main.create_enemy_waves(cantidad_enemigos,colores_enemigos_1,posicion_enemigos_1)
	main.create_enemy_waves(cantidad_enemigos,colores_enemigos_2,posicion_enemigos_2)
	
	
	# Agregamos un limite para la camara derecha
	camera.limit_right = 1700 + 1280/2
	
	# Eliminamos el area 2d que spawnea los enemigos
	zone_2.queue_free()
	camera.limit_right = 10000000
	timer.start(5.0)
	timer_2.start(20.0)
	move_right_limit()
	
func _on_timer_timeout() -> void:
	
	if !boss_spawned:
		var cantidad_enemigos_2 = 3
		var colores_enemigos_1_2 : Array[String]= ["purple","purple","purple"]
		var colores_enemigos_2_2 : Array[String]=  ["purple","purple","purple"]
		var posicion_enemigos_1_2 = Vector2(1700,600)
		var posicion_enemigos_2_2 = Vector2(1700,400)
		main.create_enemy_waves(cantidad_enemigos_2, colores_enemigos_1_2, posicion_enemigos_1_2)
		main.create_enemy_waves(cantidad_enemigos_2, colores_enemigos_2_2, posicion_enemigos_2_2)
		
		boss_spawned = true


func _on_timer2_2_timeout() -> void:
	Debug.log(str(boss_spawned))
	if boss_spawned :
		Debug.log(str(get_alive_enemies_count()))
		var boss_scene = BOSS.instantiate()
		enemies.add_child(boss_scene)
		# Posicionar la oleada
		boss_scene.global_position = marker_2d.global_position
		move_right_limit()
