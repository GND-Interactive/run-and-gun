extends CharacterBody2D

@onready var sprite = $Icon
@onready var animation_player = $AnimationPlayer
@onready var shader_mat := material as ShaderMaterial
@onready var hitboxdown: hitbox = $Hitboxdown
@onready var hitboxleft: hitbox = $Hitboxleft
@onready var hitbox_right: hitbox = $HitboxRight
@onready var hitboxup: hitbox = $Hitboxup
@onready var fsm = $FiniteStateMachine

@onready var chase: Timer = $Chase
@onready var state: Timer = $state
var target_position: Vector2 = Vector2.ZERO


@export var hp := 1
var mode := 0
var direction := Vector2.ZERO
var last_sent_position := Vector2.ZERO
var speed = 700
var player_chase = false
var player_shoot = false
var player = null


func _ready():
	if multiplayer.is_server():
		set_multiplayer_authority(multiplayer.get_unique_id())

		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
		chase.connect("timeout", Callable(self,"on_chase_timeout"))
	chase.start()
	

	set_physics_process(multiplayer.is_server())
	

func _process(_delta):
	if not multiplayer.is_server():
		return


func _physics_process(delta):
	if not multiplayer.is_server():
		return  

	if player_chase:
		var direction = (target_position - global_position)
		if direction.length() < 10:  
			player_chase = false
			velocity = Vector2.ZERO
			state.start()
		else:
			direction = direction.normalized()
			velocity = direction * speed
			move_and_collide(delta * velocity)

		
	


@rpc("call_local", "unreliable")
func sync_position(pos: Vector2, flip: bool):
	if multiplayer.is_server():
		return
	global_position = pos
	sprite.flip_h = flip


func get_nearest_player() -> Node2D:
	var players_container = get_parent().get_parent().find_child("Players")
	if not players_container:
		return null

	var players = players_container.get_children()
	if players.size() == 0:
		return null

	# Filtrar jugadores vivos
	var alive_players = []
	for player in players:
		if player.hp > 0:
			alive_players.append(player)

	if alive_players.size() == 0:
		return null  # Todos están muertos

	return alive_players[randi() % alive_players.size()]





@rpc("call_local", "reliable")
func set_mode(new_mode: int):
	mode = new_mode
	shader_mat.set_shader_parameter("mode", mode)
	set_hitbox(mode)

func _on_timer_timeout():
	if multiplayer.is_server():
		var new_mode = randi() % 4
		rpc("set_mode", new_mode)

func set_hitbox(new_mode: int):
	if new_mode == 0 or new_mode == 1:
		hitboxup.monitoring = false
		hitboxdown.monitoring = false
		hitboxleft.monitoring = true
		hitbox_right.monitoring = true
		print(hitboxdown.monitoring)
		if new_mode == 0:
			hitboxleft.color= Color.RED
			hitbox_right.color = Color.BLUE
		else:
			hitboxleft.color = Color.BLUE
			hitbox_right.color = Color.RED
	else:
		hitboxup.monitoring = true
		hitboxdown.monitoring = true
		hitboxleft.monitoring = false
		hitbox_right.monitoring = false
		print(hitboxdown.monitoring)
		if new_mode==2:
			hitboxup.color= Color.RED
			hitboxdown.color= Color.BLUE
		else:
			hitboxup.color = Color.BLUE
			hitboxdown.color= Color.RED


@rpc("call_local")
func change_state():
	var mode_ = 0
	var player_ = get_nearest_player()
	if mode_ == 0:
		dash(player_)

@rpc("call_local")
func dash(player_):
	player = player_
	if player:
		target_position = player.global_position 
		player_chase = true
		
@rpc("call_local")
func rayo(player):
	pass
@rpc("call_local")
func _on_chase_timeout() -> void:
	Debug.log("ratata")
	player_chase = false
	state.start()
	

func _on_state_timeout() -> void:
	Debug.log("state cambio")
	change_state()
func win():
	self.get_node("../../Camera2D/WinScreen").win()
