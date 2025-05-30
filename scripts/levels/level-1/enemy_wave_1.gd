extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Enemies: Node2D = $Path2D/PathFollow2D/Node2D

## Ruta de la escena de los enemigos individuales
const FLYING_ENEMY = preload("res://scenes/enemies/FlyingEnemy.tscn")

## Cantidad de separacion entre enemigos de la oleada
var separation : float = 200.0

func _ready() -> void:
	pass

## Funcion que añade los colores a cada enemigo
## Los enemigos son creados previamente por @create_enemies
func set_wave_colors(colores: Array[String]) -> void:
	# El enemigo actual al que le estamos agregando un color
	var i = 0
	for flyingEnemy in Enemies.get_children():
		if i < colores.size():
			flyingEnemy.set_color(colores[i])
		else:
			flyingEnemy.set_color()  # Usa el color por defecto
		i += 1

## Funcion que crea enemigos
## @number_of_enemies es la cantidad de enemigos que se crean
func create_enemies(number_of_enemies: int = 3) -> void :
	for i in range(number_of_enemies):
		var enemy = FLYING_ENEMY.instantiate()
		# Posicionarlos separados horizontalmente
		enemy.position = Vector2( i * separation,0)
		# Instanciar enemigos en el nodo Enemies
		Enemies.add_child(enemy)
		
## Funcion para iniciar la animacion Move_enemies
func move_enemies() -> void:
	animation_player.play("Move_enemies")
