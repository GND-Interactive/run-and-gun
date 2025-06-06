extends CharacterBody2D
 
@onready var player = get_parent().find_child("player")
@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar
 
var direction : Vector2
var DEF = 0
 
var health = 10:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff") 
 
func _ready():
	set_physics_process(false)
 
func _process(_delta):
	direction = player.position - position
 
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
 
func take_damage():
	health -= 10 - DEF
