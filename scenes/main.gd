extends Node2D

@onready var players: Node2D = $Players
@onready var spawn: Node2D = $Spawn
@export var player_scene_1 = preload("res://scenes/players/Player-1.tscn")
@export var player_scene_2= preload("res://scenes/players/Player-2.tscn")
var player_scenes = [player_scene_1, player_scene_2]
@onready var borders: Node2D = $borders

@onready var enemies: Node2D = $Enemies

const BOSS = preload("res://scenes/boss.tscn")

const ENEMY_WAVE_1 = preload("res://scenes/levels/enemy-wave-1.tscn")

func _ready() -> void:
	for i in Game.players.size():
		var player=Game.players[i]
		var player_inst= player_scenes[i].instantiate()
		if i == 0:
			player_inst.color = Color.BLUE
		else:
			player_inst.color = Color.RED
		players.add_child(player_inst)
		player_inst.setup(player)
		player_inst.global_position= spawn.get_child(i).global_position
	

## Comprobamos si movemos los enemigos
func _process(delta: float) -> void:
	pass
	
func create_enemy_waves(amount: int, colores: Array[String], position: Vector2) -> void:
	var wave = ENEMY_WAVE_1.instantiate()
	enemies.add_child(wave)
	# Posicionar la oleada
	wave.position = position
	
	# Llama a los metodos de la oleada
	wave.create_enemies(amount)
	wave.set_wave_colors(colores)
