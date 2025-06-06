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


var hp := 10
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
		pass
	if player_chase and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
	


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

	return players[randi() % players.size()]


# ---------------------------
# SALUD Y ESTADOS
# ---------------------------

var health := 10:
	set(value):
		health = value
		if value <= 0:
			print("QUE SUCEDE")
			self.queue_free()


@rpc("any_peer", "reliable")
func take_damage():
	if multiplayer.is_server():
		health -= 1

# ---------------------------
# COLOR / MODOS
# ---------------------------

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
	hitboxup.monitoring = (new_mode == 0 or new_mode == 1)
	hitboxdown.monitoring = (new_mode == 0 or new_mode == 1)
	hitboxleft.monitoring = (new_mode == 2 or new_mode == 3)
	hitbox_right.monitoring = (new_mode == 2 or new_mode == 3)

	if new_mode == 0:
		hitboxup.color = Color.RED
		hitboxdown.color = Color.BLUE
	elif new_mode == 1:
		hitboxup.color = Color.BLUE
		hitboxdown.color = Color.RED
	elif new_mode == 2:
		hitboxleft.color = Color.RED
		hitbox_right.color = Color.BLUE
	elif new_mode == 3:
		hitboxleft.color = Color.BLUE
		hitbox_right.color = Color.RED


@rpc("call_local")
func change_state():
	var mode_ = 0
	var player_ = get_nearest_player()
	if mode_ == 0:
		dash(player_)
@rpc("call_local")
func dash(player_):
	player = player_
	player_chase = true
	chase.start()
@rpc("call_local")
func rayo(player):
	pass
@rpc("call_local")
func _on_chase_timeout() -> void:
	player_chase = false
	state.start()
	


func _on_state_timeout() -> void:
	change_state()
func win():
	self.get_node("../../Camera2D/WinScreen").win()
