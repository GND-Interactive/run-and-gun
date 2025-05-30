extends Control
@onready var quit: Button = $VBoxContainer/Quit
func _ready() -> void:
	quit.pressed.connect(func(): get_tree().quit())

func win():
	get_tree().paused = true
	self.show()
