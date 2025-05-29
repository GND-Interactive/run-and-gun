extends CharacterBody2D

@onready var sprite = $Icon
@onready var shader_mat := material as ShaderMaterial
@onready var hitboxdown: hitbox = $Hitboxdown
@onready var hitboxleft: hitbox = $Hitboxleft
@onready var hitbox_right: hitbox = $HitboxRight
@onready var hitboxup: hitbox = $Hitboxup

var hp := 100
var direction: Vector2
var mode := 0
var last_sent_position: Vector2

@rpc("unreliable")
func sync_position(pos: Vector2, flip: bool):
	global_position = pos
	sprite.flip_h = flip

@rpc("call_local", "reliable")
func set_mode(new_mode: int):
	mode = new_mode
	shader_mat.set_shader_parameter("mode", mode)
	set_hitbox(mode)

@rpc("call_local", "reliable")
func change_state(state_name: String):
	find_child("FiniteStateMachine").change_state(state_name)

@rpc("call_local", "reliable")
func update_health_bar(new_health: int):
	hp = new_health
	if hp <= 0:
		change_state("Death")

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

func _ready():
	if multiplayer.is_server():
		set_multiplayer_authority(multiplayer.get_unique_id())

		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)

	set_physics_process(multiplayer.is_server())

func _on_timer_timeout():
	if multiplayer.is_server():
		var new_mode = randi() % 4
		set_mode(new_mode)
		rpc("set_mode", new_mode)

func get_nearest_player() -> Node2D:
	var players_container = get_parent().get_parent().find_child("Players")
	if not players_container:
		return null

	var nearest_player = null
	var min_distance = INF

	for player in players_container.get_children():
		var distance = global_position.distance_to(player.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest_player = player

	return nearest_player

func _process(_delta):
	if not multiplayer.is_server():
		return

	var target_player = get_nearest_player()
	if not target_player:
		return

	direction = target_player.global_position - global_position
	sprite.flip_h = direction.x < 0

func _physics_process(delta):
	if not multiplayer.is_server():
		return

	if direction.length() > 5:
		var target_velocity = direction.normalized() * 100
		velocity = velocity.lerp(target_velocity, 0.2)
		move_and_collide(velocity*delta)

		# Solo enviar si hay un cambio significativo
		if global_position.distance_to(last_sent_position) > 5:
			last_sent_position = global_position
			sync_position(global_position, sprite.flip_h)

@rpc("any_peer", "reliable")
func take_damage():
	if multiplayer.is_server():
		hp -= 10
		rpc("update_health_bar", hp)

		if hp <= 0:
			rpc("change_state", "Death")
