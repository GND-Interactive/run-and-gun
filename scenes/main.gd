extends Node2D

@onready var players: Node2D = $Players
@onready var spawn: Node2D = $Spawn
@export var player_scene: PackedScene

func _ready() -> void:
	for i in Game.players.size():
		var player=Game.players[i]
		var player_inst= player_scene.instantiate()
		players.add_child(player_inst)
		player_inst.setup(player)
		player_inst.global_position= spawn.get_child(i).global_position
