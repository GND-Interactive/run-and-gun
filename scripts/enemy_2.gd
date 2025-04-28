
extends CharacterBody2D
var color:Color = Color(1,0,0)
var alive  = true
var hp = 5


func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area)
	if area.b_color == color:
		area.borrar.rpc()
		dead.rpc()
		
@rpc("call_local")
func dead():
	self.queue_free()
