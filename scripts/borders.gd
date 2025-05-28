extends Node2D

#Este Script maneja los limites de cada nivel
@onready var enemies: Node2D = $"../Enemies"
@onready var right_limit: StaticBody2D = $"right-limit"
@onready var timer: Timer = $"../Timer"
@onready var camera: Camera2D = $"../Camera2D"


var CHANGE_STAGE_OFFSET: float = 500

# Esta funcion es solo para probar la funcionalidad de mover el limite derecho
func _ready():
	await get_tree().create_timer(30.0).timeout
	remove_all_enemies()
	move_right_limit()

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
	var count := 0
	for enemy in enemies.get_children():
		if enemy.is_inside_tree():  # asegúrate de que aún existe
			count += 1
	return count
	

func _process(delta: float) -> void:
	print("Enemigos vivos: ", get_alive_enemies_count())
