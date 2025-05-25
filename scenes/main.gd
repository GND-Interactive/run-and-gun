extends Node2D

@onready var players: Node2D = $Players
@onready var spawn: Node2D = $Spawn
@export var player_scene_1 = preload("res://scenes/players/Player-1.tscn")
@export var player_scene_2= preload("res://scenes/players/Player-2.tscn")
var player_scenes = [player_scene_1, player_scene_2]

func _ready() -> void:
	for i in Game.players.size():
		var player=Game.players[i]
		print(player_scenes)
		var player_inst= player_scenes[i].instantiate()
		if i == 0:
			player_inst.color = Color.BLUE
		else:
			player_inst.color = Color.RED
		print(player_inst.color)
		players.add_child(player_inst)
		player_inst.setup(player)
		print(players)
		player_inst.global_position= spawn.get_child(i).global_position
