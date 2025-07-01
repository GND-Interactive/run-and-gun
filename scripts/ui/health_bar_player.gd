extends Control

## Esta escena se convertira en la interfaz del juego

# Barra de vida y texto de vida jugador 1
@onready var progress_bar_1: ProgressBar = $ProgressBar
@onready var health_text_1: Label = $ProgressBar/Label
# Barra de vida y texto de vida jugador 2
@onready var progress_bar_2: ProgressBar = $ProgressBar2
@onready var health_text_2: Label = $ProgressBar2/Label
# Timer para el Tiempo de partida
@onready var timer_2: Timer = $Timer2
@onready var level_timer: Label = $Label

## Vida maxima y vida inicial de los jugadores
var max_hp = 2

func _ready() -> void:
	health_text_1.text = "HP = " + str(max_hp)
	health_text_2.text = "HP = " + str(max_hp)

## Funcion update health bars
##
## Actualiza la barra de vida de acuerdo a la vida actual de ambos jugadores
func update_health_bars(player_1_health: int, player_2_health: int) -> void:
	# Asignar vida player 1
	progress_bar_1.value = player_1_health
	health_text_1.text = "HP = " + str(player_1_health)
	# Asignar vida player 2
	progress_bar_2.value = player_2_health
	health_text_2.text = "HP = " + str(player_2_health)
	print("health bars updated")

	
## Funcion timer
##
## Controla el tiempo en pantalla
func _on_timer_2_timeout() -> void:
	# Se actualiza el tiempo casa segundo
	level_timer.text = str(int(level_timer.text) - 1)
