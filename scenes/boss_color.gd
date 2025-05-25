extends Sprite2D

@onready var shader_mat := material as ShaderMaterial
var mode := 0

# Función para cambiar el color desde el servidor
func _ready():
	Debug.log("Shader material:" + str(shader_mat))  # Verifica si el material está asignado correctamente
	print("¿Es servidor?:", multiplayer.get_unique_id())  # Verifica si estamos en el servidor
	
	if multiplayer.is_server():
		set_multiplayer_authority(multiplayer.get_unique_id())  # Asignar autoridad al servidor
		
		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		timer.one_shot = false
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)

# RPC para sincronizar el cambio de modo (color) entre servidor y cliente
@rpc("call_local", "reliable")  # "call_local" asegura que el RPC se ejecute solo localmente
func set_mode(new_mode: int):
	print("Modo recibido en set_mode:", new_mode)  # Verifica que se recibe el nuevo modo
	mode = new_mode
	shader_mat.set_shader_parameter("mode", mode)  # Actualiza el parámetro del shader
	set_hitbox(mode)

# Función que ejecuta el temporizador en el servidor y envía el cambio a todos los clientes
func _on_timer_timeout():
	if multiplayer.is_server():
		var new_mode = randi() % 4  # Genera un valor aleatorio entre 0 y 3
		print("Servidor decide nuevo modo:", new_mode)  # Verifica el valor generado
		rpc("set_mode", new_mode)  # Envía el nuevo modo a todos los clientes
		
func set_hitbox(new_mode: int):
	if new_mode == 0 or new_mode == 1:
		pass
		if new_mode == 0:
			pass
		else:
			pass
	else:
		pass
		if new_mode==2:
			pass
		else:
			pass
			
