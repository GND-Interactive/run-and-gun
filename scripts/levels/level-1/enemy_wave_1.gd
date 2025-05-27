extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Enemies: Node2D = $Path2D/PathFollow2D/Node2D

## Esta variable almacena las debilidades de los enemigos
var debilidades : Array[String] 

# Le pasamos
func _ready() -> void:
	animation_player.play("Move_enemies")
	set_wave_colors(["red","purple","blue"])
	

func set_wave_colors(colores: Array[String]) -> void:
	debilidades = colores
	# El enemigo actual al que le estamos agregando un color
	var i = 0
	for flyingEnemy in Enemies.get_children():
		# Obtenemos el sprite para cambiarle el color
		flyingEnemy.set_color(debilidades[i])
		i+=1
