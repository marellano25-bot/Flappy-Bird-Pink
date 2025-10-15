extends CharacterBody2D
class_name Bird

# Configuración de movimiento
@export var gravity := 1000.0
@export var jump_force := 300.0


@onready var anim = $AnimatedSprite2D
#lucas

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
	
func use_power_up():
	var powerUpDuration= 5
	anim.play("Rodrigo")
	await get_tree().create_timer(powerUpDuration).timeout
	# Revert to normal animation
	anim.play("idle")
		
