extends CharacterBody2D

@onready var input_sync: input_sync = $InputSync
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree["parameters/playback"]
var speed = 300
var acceleration = 2000
var player_alive = true
var color :Color 
var damage= 1
@onready var bullet_spawner: Marker2D = $BulletSpawner
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var pivot: Node2D = $Pivot
@onready var fire_cd: Timer = $FireCD

func _physics_process(delta: float) -> void:
	
	# Movimiento
	var move_input = input_sync.move_input
	
	velocity.x = move_toward(velocity.x, move_input.x * speed, acceleration * delta)
	velocity.y = move_toward(velocity.y, move_input.y * speed, acceleration * delta)
	if input_sync.fire:
		input_sync.fire = false
		if is_multiplayer_authority() and  fire_cd.is_stopped():
			fire.rpc_id(1,input_sync.fire_dir)
			fire_cd.start()
	if move_input.x:
		pivot.scale.x= sign(move_input.x)
		
	if not move_input.is_zero_approx():
		update_animation_state(true)
	else:
		update_animation_state(false)
	
		
		
	

	# Movimiento físico
	move_and_slide()

	
func setup(player_data: Statics.PlayerData):
	label.text=player_data.name
	name=str(player_data.id)
	set_multiplayer_authority(player_data.id, false)
	input_sync.set_multiplayer_authority(player_data.id)
	if is_multiplayer_authority():
		timer.timeout.connect(_on_sync)
		timer.start()
		
@rpc("unreliable_ordered")	
func send_data(pos:Vector2, vel:Vector2)-> void:
	position=lerp(position,pos,0.5)
	velocity=velocity.lerp(vel,0.5)
	
	

func _on_sync()-> void:
	send_data.rpc(position,velocity)
@rpc("call_local")
func fire(direction:Vector2):
	Debug.log("fire")
	var bullet_inst = bullet_scene.instantiate()
	bullet_inst.global_position = bullet_spawner.global_position
	print(color)
	bullet_inst.change_color(color)
	bullet_inst.direction = direction.normalized()
	multiplayer_spawner.add_child(bullet_inst,true)
@rpc("call_local")
func update_animation_state(is_moving: bool):
	if is_moving:
		playback.travel("Walk")
	else:
		playback.travel("Idle")


## Bloquea el movimiento en dirección opuesta al otro jugador si están demasiado lejos
func limit_movement(opponent_position: Vector2, max_distance: float):
	var direction_to_opponent = opponent_position.x - global_position.x
	var move_input = input_sync.move_input.x

	var is_moving_away = sign(move_input) != sign(direction_to_opponent) and abs(global_position.x - opponent_position.x) > max_distance
	
	if is_moving_away:
		velocity.x = 0
		acceleration = 0
	else:
		acceleration = 2000  # Restauramos la aceleración si se mueve hacia el otro jugador

	
