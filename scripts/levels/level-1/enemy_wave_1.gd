extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

## Esta variable almacena las debilidades de los enemigos
var debilidades : Array[String] 

# Le pasamos
func _ready() -> void:
	animation_player.play("Move_enemies")


func set_wave_colors(colors: Array[String]) -> void:
	pass
