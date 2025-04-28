extends Area2D
@export var speed = 800
@export var direction = Vector2.RIGHT
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var b_color = Color.WHITE
func _ready() -> void:
	sprite_2d.modulate = b_color
	rotation = direction.angle()
func _physics_process(delta: float) -> void:
	position += speed * direction *delta
func change_color(color):
	b_color = color
	pass


@rpc("call_local")
func borrar():
	self.queue_free()
