extends Area2D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var debilidad : Color

var debilidades = {
	"red" : Color(1,0,0),
	"blue" : Color(0,0,1),
	"purple": Color(1,0,1),
}


func _ready() -> void:
	print("Debilidad del enemigo: ", debilidad)
	animation_player.play("Fly")

## Método para setear el color usando un string
## Los colores disponibles son "red", "blue" y "purple"
## Si no se especifica el color, se pinta de color "purple"
func set_color(color_name: String = "purple") -> void:
	if debilidades.has(color_name):
		debilidad = debilidades[color_name]
	else:
		debilidad = debilidades["purple"]  # Valor por defecto
	sprite.modulate = debilidad
	print("Seteado el color ", debilidad, " como debilidad")


func _procces(delta: float) -> void:
	sprite.modulate = debilidad
