extends Area2D

@onready var invulnerability: Timer = $Invulnerability

func _on_area_entered(area: Area2D) -> void:
	take_damage.rpc()
	
	
@rpc("call_local")
func take_damage():
	self.get_parent().hp -= 1
		
	if self.get_parent().hp == 0:
		self.get_parent().lose()
		self.get_parent().set_physics_process(false)
		self.get_parent().animation_player.play("Death")

	Debug.log(self.get_parent().hp)
