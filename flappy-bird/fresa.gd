extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var tiempo_inmunidad := 5.0
@export var tiempo_reaparicion := 30.0

func _ready():
	randomize()
	posicionar_aleatoriamente()
	body_entered.connect(_on_body_entered)

# Colocar la fresa en una posición aleatoria
func posicionar_aleatoriamente():
	var _viewport_size = get_viewport_rect().size
	var _margen = 40
	var x = randf_range(80, 100)
	var y = randf_range(200, 350)
	position = Vector2(x, y)

# Cuando Bird choca con la fresa
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		print("Fresa consumida!")
		sprite.hide()
		collision.disabled = true

		# Activar inmunidad
		if body.has_method("activar_inmunidad"):
			body.activar_inmunidad(tiempo_inmunidad)

		# Cambiar apariencia (usa animación "Rodrigo")
		if body.has_method("use_power_up"):
			body.use_power_up()

		await get_tree().create_timer(tiempo_reaparicion).timeout
		posicionar_aleatoriamente()
		sprite.show()
		collision.disabled = false
		
