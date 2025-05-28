extends Area2D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

## Vida del enemigo son 2 disparos
var hp : int = 2

## Debilidad y color del enemigo
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
	debilidad = color_name
	if debilidades.has(color_name):
		debilidad = debilidades[color_name]
	else:
		debilidad = debilidades["purple"]  # Valor por defecto
	sprite.modulate = debilidad
	print("Seteado el color ", debilidad, " como debilidad")

## Funcion que maneja las colisiones con las balas
func _on_area_entered(bullet: Area2D) -> void:
	Debug.log(bullet.name)
	if bullet is Bullet && bullet.b_color == debilidad:
		if hp == 1 :
			Debug.log(bullet.get_class())
			bullet.borrar.rpc()
			dead.rpc()
		else:
			hp -= 1
	
@rpc("call_local")
func dead():
	self.queue_free()
