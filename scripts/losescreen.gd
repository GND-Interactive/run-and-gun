extends Control
@onready var quit: Button = $CenterContainer/VBoxContainer/Quit
func _ready() -> void:
	quit.pressed.connect(func(): get_tree().quit())

func lose():
	get_tree().paused = true
	self.show()
