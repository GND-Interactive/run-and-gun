class_name input_sync
extends MultiplayerSynchronizer
@export var move_input: Vector2
@export var fire:bool
@export var fire_dir = Vector2.ZERO
func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		move_input= Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		var dir = Vector2.ZERO
		if Input.is_action_just_pressed("shoot_up"):
			dir = Vector2.UP
		if Input.is_action_just_pressed("shoot_down"):
			dir  = Vector2.DOWN
		if Input.is_action_just_pressed("shoot_right"):
			dir = Vector2.RIGHT
		if Input.is_action_just_pressed("shoot_left"):
			dir = Vector2.LEFT
		if dir != Vector2.ZERO:
			fire_dir = dir
			trigger_fire.rpc()

@rpc("call_local","reliable")
func trigger_fire():
	fire = true
		
