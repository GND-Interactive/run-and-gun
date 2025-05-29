extends State
 
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
