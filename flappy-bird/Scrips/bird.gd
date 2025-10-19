extends CharacterBody2D

# Configuración de movimiento
@export var gravity := 1000.0
@export var jump_force := 300.0

@onready var anim = $AnimatedSprite2D

# Estado del pájaro
var inmune: bool = false

func _ready() -> void:
	print("Script de Bird cargado correctamente")

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	velocity.y += gravity * delta

	# Saltar al presionar espacio
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_force

	# Mover el pájaro
	move_and_slide()


#Función de power-up visual (Rodrigo)
func use_power_up():
	var powerUpDuration = 5
	print("Activando animación Rodrigo")
	anim.play("Rodrigo")
	await get_tree().create_timer(powerUpDuration).timeout
	print("Volviendo a animación normal")
	anim.play("Fly")


#Función de inmunidad
func activar_inmunidad(tiempo):
	inmune = true
	print("Bird es inmune por ", tiempo, " segundos")
	anim.play("Rodrigo")

	await get_tree().create_timer(tiempo).timeout
	inmune = false
	print("Inmunidad terminada")
	anim.play("Fly")
	
	var en_inmunidad = false
