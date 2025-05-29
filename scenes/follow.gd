extends State

func enter():
	super.enter()
	if multiplayer.is_server():
		owner.set_physics_process(true)
		owner.animation_player.play("idle")

func exit():
	super.exit()
	if multiplayer.is_server():
		owner.set_physics_process(false)

func physics_process(delta):
	if multiplayer.is_server():
		owner.move_towards_player(delta)

@rpc("call_local", "reliable")
func transition():
	if multiplayer.is_server():
		var distance = owner.direction.length()
		if distance < 0.1:
			get_parent().change_state("MeleeAttack")
