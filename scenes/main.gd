extends Node2D

@onready var players: Node2D = $Players
@onready var spawn: Node2D = $Spawn
@export var player_scene_1 = preload("res://scenes/players/Player-1.tscn")
@export var player_scene_2= preload("res://scenes/players/Player-2.tscn")
var player_scenes = [player_scene_1, player_scene_2]

@onready var enemies: Node2D = $Enemies

const ENEMY_WAVE_1 = preload("res://scenes/levels/enemy-wave-1.tscn")

func _ready() -> void:
	for i in Game.players.size():
		var player=Game.players[i]
		print(player_scenes)
		var player_inst= player_scenes[i].instantiate()
		if i == 0:
			player_inst.color = Color(0,0,1)
		else:
			player_inst.color = Color(1,0,0)
		print(player_inst.color)
		players.add_child(player_inst)
		player_inst.setup(player)
		print(players)
		player_inst.global_position= spawn.get_child(i).global_position
		create_enemy_waves()


func create_enemy_waves() -> void:
	var wave = ENEMY_WAVE_1.instantiate()
	enemies.add_child(wave)
	# Posicionar la oleada
	wave.position = Vector2(750.0,577.0)
	# Esperar un frame para que la escena termine de instanciar nodos (importante para que funcione `await get_tree().process_frame`)
	#await get_tree().process_frame()
	
	# Llama a los metodos de la oleada
	wave.create_enemies(2)
	var colores : Array[String] = ["blue","red"]
	wave.set_wave_colors(colores)
