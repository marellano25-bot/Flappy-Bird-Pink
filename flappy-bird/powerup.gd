extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var tiempo_reaparicion := 10.0
@export var velocidad := 150
@export var tiempo_inmunidad: float = 5.0

@onready var swoosh_sound = $swoosh_sound


var coold = false
var en_reaparicion: bool = false
var x = 350
var y = randf_range(120, 320)

func _ready() -> void:
	sprite.hide()
	await get_tree().create_timer(5).timeout
	sprite.show()
	randomize()
	posicionar_aleatoriamente()
	body_entered.connect(_on_body_entered)

# Coloca la fresa (power-up) en una posición aleatoria
func posicionar_aleatoriamente() -> void:
	var viewport_size = get_viewport_rect().size
	var margen = 40
	position = Vector2(randf_range(margen, viewport_size.x - margen), randf_range(110, 300))

# Para que se mueva como el resto del entorno
func _process(delta: float) -> void:
	if sprite.visible:
		position.x -= velocidad * delta
		if position.x <= -50:
			await get_tree().create_timer(5).timeout
			position.x = x
			posicionar_aleatoriamente()

# Cuando Bird choca con la fresa
func _on_body_entered(body: Node2D) -> void:
	if en_reaparicion or coold:
		print("cooldown o en reaparición activa")
		return
	if body.name == "Bird":
				swoosh_sound.play()

	if body.name == "Bird":
		coold = true
		en_reaparicion = true
		sprite.hide()
		collision.disabled = true

		if body.has_method("activar_inmunidad"):
			body.activar_inmunidad(tiempo_inmunidad)
		if body.has_method("use_power_up"):
			body.use_power_up()

		await get_tree().create_timer(tiempo_reaparicion).timeout

		posicionar_aleatoriamente()
		sprite.show()
		collision.disabled = false
		coold = false
		en_reaparicion = false
 
