extends Control
@onready var quit: Button = $VBoxContainer/Quit
func _ready() -> void:
	quit.pressed.connect(func(): Lobby.go_to_lobby())

func win():
	get_tree().paused = true
	self.show()
