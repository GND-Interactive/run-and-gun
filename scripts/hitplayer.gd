extends Area2D

@onready var invulnerability: Timer = $Invulnerability
var can_take_damage := true

func _ready():
	invulnerability.timeout.connect(_on_Invulnerability_timeout)

func _on_area_entered(area: Area2D) -> void:
	if can_take_damage:
		take_damage.rpc()

	
	
@rpc("call_local")
func take_damage():
	if not can_take_damage:
		return

	can_take_damage = false  

	self.get_parent().hp -= 1

	if self.get_parent().hp == 0:
		self.get_parent().set_physics_process(false)
		self.get_parent().playback.travel("Death")
		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
	else:
		invulnerability.start()  

	Debug.log(self.get_parent().hp)


func _on_timer_timeout():
	self.get_parent().lose()
func _on_Invulnerability_timeout():
	can_take_damage = true
