extends CharacterBody2D

# Configuración de movimiento
@export var gravity := 1000.0
@export var jump_force := 300.0

func _ready() -> void:
	print("Script funcionando correctamente ✅")

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	velocity.y += gravity * delta

	# Saltar al presionar espacio
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_force

	# Mover el pájaro
	move_and_slide()
