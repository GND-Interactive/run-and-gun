extends Control

## Esta escena se convertira en la interfaz del juego
## TODO 
## 1. Añadir timer al centro de las barras de vida
## 2. Añadir numeros que indiquen la cantidad de vida del jugador

@onready var progress_bar_1: ProgressBar = $ProgressBar
@onready var progress_bar_2: ProgressBar = $ProgressBar2
@onready var damage_timer: Timer = $Timer

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

	print("Escena lista. Daño cada", damage_timer.wait_time, "segundos.")

func _on_damage_timer_timeout():
	if vida > 0:
		vida -= 1
		progress_bar_1.value = vida
		progress_bar_2.value = vida
		print("Daño recibido. Vida actual:", vida)
	else:
		print("¡Sin vida!")
		damage_timer.stop()
