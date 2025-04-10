extends Node2D
@onready var timer: Timer = $Timer
@onready var players = get_tree().get_first_node_in_group("Players")
@onready var spawns = get_tree().get_first_node_in_group("enemy_spawns")
@onready var enemies: Node2D = $"../Enemies"

@export var enemy = preload("res://scenes/enemies/enemy.tscn")

var time = 0



	
@rpc("call_local")
func _on_timer_timeout() -> void:
	print("timerout")
	var new_enemy = enemy.instantiate()
	new_enemy.global_position = spawns.pick_random()
	enemies.add_child(new_enemy)
	print("new enemy spawned")
