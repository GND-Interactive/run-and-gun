extends Node2D

#Este Script maneja los limites de cada nivel
@onready var enemies: Node2D = $"../Enemies"
@onready var right_limit: StaticBody2D = $"right-limit"
@onready var timer: Timer = $"../Timer"
@onready var camera: Camera2D = $"../Camera2D"
@onready var zone_2: Area2D = $Area2D
@onready var main: Node2D = $".."

## Indica la zona actual de la etapa en la que se encuentran los jugadores
var current_zone : String = 'Zone-1'

## Indica que tanto se movera el limite derecho del juego
var CHANGE_STAGE_OFFSET: float = 500

# Esta funcion es solo para probar la funcionalidad de mover el limite derecho
func _ready():
	#await get_tree().create_timer(5.0).timeout
	#remove_all_enemies()
	#move_right_limit()
	pass
	
#Elimina todos los enemigos
func remove_all_enemies():
	for enemy in enemies.get_children():
		enemy.queue_free()
		
# Mueve el limite derecho a la siguiente stage
# Genera un desplazamiento a la derecha del limite derecho
func move_right_limit() -> void:
	right_limit.position.x += CHANGE_STAGE_OFFSET
	return

func get_alive_enemies_count() -> int:
	return enemies.get_child_count()

func _process(delta: float) -> void:
	#Debug.log("Enemigos vivos")
	#Debug.log(get_alive_enemies_count())
	if get_alive_enemies_count() == 0 && current_zone == 'Zone-2':
		#Movemos los limites si se mataron a todos los enemigos
		current_zone = 'transition-level-2'


## Bloquea la camara
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Enemigos
	# Aqui instanciamos los enemigos
	var cantidad_enemigos = 3
	var colores_enemigos_1 : Array[String]= ["red","red","red"]
	var colores_enemigos_2 : Array[String]=  ["blue","blue","blue"]
	var posicion_enemigos_1 = Vector2(1700,600)
	var posicion_enemigos_2 = Vector2(1700,400)
	main.create_enemy_waves(cantidad_enemigos,colores_enemigos_1,posicion_enemigos_1)
	main.create_enemy_waves(cantidad_enemigos,colores_enemigos_2,posicion_enemigos_2)
	
	if body is not CharacterBody2D:
		return
		
	Debug.log("Entrada Zona 2")
	if body.is_in_group("Players") :
		Debug.log("Haz entrado en la Zona 2")
		
	Debug.log(body.name)
	current_zone = 'Zone-2'
	camera.limit_right = 1700 + 1280/2
	## Elinamos el nodo para no cargar nuevamente
	## Iniciamos el movimiento de la oleada de enemigos
	#for enemy in enemies.get_children():
	#	enemy.move_enemies()
		
	zone_2.queue_free()
		
	
	
	
