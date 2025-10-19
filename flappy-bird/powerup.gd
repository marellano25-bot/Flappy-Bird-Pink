extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var tiempo_inmunidad: float = 5.0
@export var tiempo_reaparicion: float = 10.0

var en_reaparicion: bool = false

func _ready() -> void:
	randomize()
	posicionar_aleatoriamente()
	body_entered.connect(_on_body_entered)

# Coloca la fresa (power-up) en una posición aleatoria
func posicionar_aleatoriamente() -> void:
	var viewport_size = get_viewport_rect().size
	var margen = 40
	var x = randf_range(margen, viewport_size.x - margen)
	var y = randf_range(110, 300)
	position = Vector2(x, y)

# Cuando Bird choca con la fresa
func _on_body_entered(body: Node2D) -> void:
	if en_reaparicion:
		return  # Ignora si ya está desaparecida o en proceso

	if body.name == "Bird":
		print("¡Power-up consumido!")

		en_reaparicion = true
		sprite.hide()
		collision.disabled = true

		# Activa inmunidad si Bird tiene el método
		if body.has_method("activar_inmunidad"):
			body.activar_inmunidad(tiempo_inmunidad)

		# Cambia apariencia (Rodrigo)
		if body.has_method("use_power_up"):
			body.use_power_up()

		# Esperar reaparición
		await get_tree().create_timer(tiempo_reaparicion).timeout

		posicionar_aleatoriamente()
		sprite.show()
		collision.disabled = false
		en_reaparicion = false
