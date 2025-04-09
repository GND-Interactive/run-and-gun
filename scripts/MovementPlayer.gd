extends CharacterBody2D
@onready var input_sync: input_sync = $InputSync
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var speed = 300
var acceleration = 2000
var player_alive = true
var color = null
var damage= 1

func _physics_process(delta: float) -> void:
	
	# Movimiento
	var move_input = input_sync.move_input
	
	velocity.x = move_toward(velocity.x, move_input.x * speed, acceleration * delta)
	velocity.y = move_toward(velocity.y, move_input.y * speed, acceleration * delta)

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
	
