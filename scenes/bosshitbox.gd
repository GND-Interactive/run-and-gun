extends Area2D
class_name hitbox
@export var color = Color.WHITE


func _on_area_entered(area: Area2D) -> void:
	if "b_color" in area:
		Debug.log(area.b_color)
		if area.b_color == color:
			area.borrar.rpc()
			take_damage.rpc()
		else:
			area.borrar.rpc()
	else:
		pass
		
@rpc("call_local")
func take_damage():
	self.get_parent().hp -=1
	if self.get_parent().hp == 0:
		self.get_parent().win()
		self.get_parent().queue_free()
	Debug.log(self.get_parent().hp)

	
		
