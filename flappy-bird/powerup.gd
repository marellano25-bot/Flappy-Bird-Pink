extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var tiempo_inmunidad := 5.0
@export var tiempo_reaparicion := 10.0

func _ready():
	randomize()
	posicionar_aleatoriamente()
	body_entered.connect(_on_body_entered)

#Colocamos la fresa en una posición aleatoria al inicio
func posicionar_aleatoriamente():
	var _viewport_size = get_viewport_rect().size
	var _margen = 40

	# 🟢 Fresa aparece entre 80 y 180px en eje X (zona jugable para Bird)
	var x = randf_range(75, 100)

	# 🟢 Ajuste del eje Y para que esté en el rango medio de vuelo de Bird
	var y = randf_range(200, 350)

	position = Vector2(x, y)

#Cuando Bird choca con la fresa
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		print("¡Fresa consumida!")
		sprite.hide()
		collision.disabled = true

		# Aquí puedes activar la inmunidad de Bird
		if body.has_method("activar_inmunidad"):
			body.activar_inmunidad(tiempo_inmunidad)

		await get_tree().create_timer(tiempo_reaparicion).timeout
		posicionar_aleatoriamente()
		sprite.show()
		collision.disabled = false

	if body.name == "Bird":
		var rodrigo = body.get_node_or_null("Rodrigo")
		var normal_sprite = body.get_node_or_null("AnimatedSprite2D")

		if rodrigo and normal_sprite:
			print("Power-up activado!")

			#Desaparecer fresa
			hide()
			collision.disabled = true

			#Cambiar apariencia de Bird
			rodrigo.visible = true
			normal_sprite.visible = false
			await get_tree().create_timer(tiempo_reaparicion).timeout
			posicionar_aleatoriamente()
			collision.disabled = false
			show()
