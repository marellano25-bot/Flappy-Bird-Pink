extends CharacterBody2D

# Configuración de movimiento
@export var gravity := 1000.0
@export var jump_force := 300.0

@onready var anim = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D 

var inmune: bool = false

func _physics_process(delta: float) -> void:
	velocity.x = 0 #Había faltado esta línea para que no se empezara a mover de repente
	velocity.y += gravity * delta
	# Saltar al presionar espacio
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_force
	# Mover el pájaro
	move_and_slide()


# Función de powerup visual
func use_power_up():
	collision.disabled = true
	var powerUpDuration = 5
	#Aciva a Rodrigo>
	anim.play("Rodrigo")
	await get_tree().create_timer(powerUpDuration).timeout
	#Revierte efectos>
	anim.play("Fly")
	collision.disabled = false

#Checa lo de la colisión
func activar_inmunidad(tiempo):
	inmune = true

	var original_mask = collision_mask
	print("Original mask:", original_mask)
	
	var pipe_layer_bit = 2
	
	collision_mask &= ~pipe_layer_bit #Esto para desactivar la colisión (ya sirve)
	print("New mask:", collision_mask)

	await get_tree().create_timer(tiempo).timeout
	
	collision_mask = original_mask
	inmune = false 
