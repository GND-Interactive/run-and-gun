extends Area2D
class_name hitbox
@export var color = Color.WHITE


func _on_area_entered(area: Area2D) -> void:
	if "b_color" in area:
		if area.b_color == color:
			Debug.log("daño")
			area.borrar.rpc()
			take_damage.rpc()
			
		else:
			area.borrar.rpc()
			Debug.log("No dañoa")
	else:
		pass
		
@rpc("call_local")
func take_damage():
	self.get_parent().hp -=1
	if self.get_parent().hp == 0:
		self.get_parent().set_physics_process(false)
		self.get_parent().animation_player.play("death")
		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)

	Debug.log(self.get_parent().hp)

func _on_timer_timeout():
		self.get_parent().win()
		self.get_parent().queue_free()
	

	
		
