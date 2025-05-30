extends Node2D

@onready var flying_enemy: Enemy = $FlyingEnemy
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D

func _process(delta: float) -> void:
	flying_enemy.chase_player(character_body_2d,delta)
