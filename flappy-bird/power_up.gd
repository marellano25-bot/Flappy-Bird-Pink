extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@export var tiempo_inmunidad := 5.0
@export var tiempo_reaparicion := 10.0

func _ready():
	body_entered.connect(_on_body_entered)
	randomize()
	posicionar_aleatoriamente()

func posicionar_aleatoriamente():
	var x = randf_range(200, 800)
	var y = randf_range(100, 400)
	position = Vector2(x, y)
	print("PowerUp (fresa) colocado en:", position)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		var rodrigo = body.get_node_or_null("Rodrigo")
		# 👇 Aquí cambiamos para que busque AnimatedSprite2D en vez de Sprite2D
		var normal_sprite = body.get_node_or_null("AnimatedSprite2D")

		if rodrigo and normal_sprite:
			# Activar Rodrigo, ocultar sprite normal
			rodrigo.visible = true
			normal_sprite.visible = false

			if rodrigo.has_method("play"):
				rodrigo.play("rodrigo_mid")

			# Crear temporizador para apagar el power-up
			var timer := Timer
