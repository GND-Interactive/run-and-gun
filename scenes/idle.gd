extends State

@onready var collision = $"../../PlayerDetection/CollisionShape2D"

var player_entered := false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)

func enter():
	super.enter()
	if multiplayer.is_server():
		owner.set_physics_process(false)

func transition():
	if player_entered:
		get_parent().change_state("Follow")

func _on_player_detection_body_entered(body):
	if multiplayer.is_server():
		player_entered = true
