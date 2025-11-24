extends CharacterBody2D
class_name Bird

# Configuración de movimiento
@export var gravity := 1000.0
@export var jump_force := 300.0

@onready var anim = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D 

# Configuración de sonido @onready var point_sound = $point_sound
@onready var wing_sound = $wing_sound
@onready var swoosh_sound = $swoosh_sound
@onready var point_sound = $point_sound
@onready var die_sound = $die_sound
@onready var hit_sound = $hit_sound

var inmune: bool = false
const PIPE_LAYER := 2 

func _ready() -> void:
	print("Script de Bird cargado correctamente")

func _physics_process(delta: float) -> void:
	if Global.is_start:
		velocity.x = 0 # Para que no se mueva de repente
		velocity.y += gravity * delta
		
		# Saltar al presionar espacio
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force
			wing_sound.play()  # sonido al saltar
		
		# Mover el pájaro
		move_and_slide()


	# Función de power-up visual
func use_power_up():
		var powerUpDuration = 5
		
		# Guardar animación actual
		var anim_actual = anim.animation
		
		# Activar animación del power-up
		anim.play("Rodrigo")
		await get_tree().create_timer(powerUpDuration).timeout
		
		# Volver a la animación original
		anim.play(anim_actual)
		collision.disabled = false

	# Función de inmunidad
func activar_inmunidad(tiempo: float) -> void:
		inmune = true
		
		# Guardar la máscara original de colisión
		var original_mask = collision_mask
		set_collision_mask_value(PIPE_LAYER, false)
		await get_tree().create_timer(tiempo).timeout
		
		# Restaurar colisión original
		collision_mask = original_mask
		inmune = false
