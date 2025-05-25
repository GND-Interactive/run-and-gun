extends Area2D
class_name hitbox
@export var color = Color.WHITE


func _on_area_entered(area: Area2D) -> void:
	if area.b_color == color:
		area.borrar.rpc()
		take_damage.rpc()
		
@rpc("call_local")
func take_damage():
	pass
		
