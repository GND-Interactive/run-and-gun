extends Control

## Esta escena se convertira en la interfaz del juego
## TODO 
## 1. Añadir timer al centro de las barras de vida
## 2. Añadir numeros que indiquen la cantidad de vida del jugador

# Barra de vida y texto de vida jugador 1
@onready var progress_bar_1: ProgressBar = $ProgressBar
@onready var health_text_1: Label = $ProgressBar/Label
# Barra de vida y texto de vida jugador 2
@onready var progress_bar_2: ProgressBar = $ProgressBar2
@onready var health_text_2: Label = $ProgressBar2/Label
# Timer para el Tiempo de partida
@onready var timer_2: Timer = $Timer2
@onready var level_timer: Label = $Label
# Timer de prueba para bajar la vida
@onready var damage_timer: Timer = $Timer


# Vida inicial y maxima 
var vida = 5
var max_vida = 5

func _ready():
	progress_bar_1.max_value = max_vida
	progress_bar_1.value = vida
	progress_bar_2.max_value = max_vida
	progress_bar_2.value = vida
	
	damage_timer.wait_time = 1.0  # cada 1 segundo
	damage_timer.timeout.connect(_on_damage_timer_timeout)
	damage_timer.start()  # inicia el timer

func _on_damage_timer_timeout():
	if vida > 0:
		vida -= 1
		progress_bar_1.value = vida
		health_text_1.text = "HP = %d" % vida
		progress_bar_2.value = vida
		health_text_2.text = "HP = %d" % vida
		print("Daño recibido. Vida actual:", vida)
	else:
		print("¡Sin vida!")
		damage_timer.stop()


func _on_timer_2_timeout() -> void:
	# Se actualiza el tiempo casa segundo
	level_timer.text = str(int(level_timer.text) - 1)
