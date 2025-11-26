extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var pu: AudioStreamPlayer2D = $powerup

@export var tiempo_reaparicion := 10.0
@export var velocidad := 150
@export var tiempo_inmunidad := 5
var coold = false
var x = 350
var y = randf_range(120, 320)

func _ready():
	sprite.hide()
	await get_tree().create_timer(5).timeout
	sprite.show()
	randomize()
	posicionar_aleatoriamente()
	body_entered.connect(_on_body_entered)

#Colocamos la fresa en una posición aleatoria al inicio
func posicionar_aleatoriamente():
	var _viewport_size = get_viewport_rect().size
	var _margen = 4
	position = Vector2(x, y)
	
#Para que se mueva como el resto del entorno
func _process(delta):
	if sprite.visible:
		position.x -= velocidad * delta
		if position.x <= -50: 
			await get_tree().create_timer(5).timeout
			position.x = x
			posicionar_aleatoriamente()
			
#Cuando Bird choca con la fresa
func _on_body_entered(body: Node2D) -> void:
	
	if coold == false: 
		if body.name == "Bird":
			coold = true
			sprite.hide()
			collision.disabled = true
			pu.play()
		
			if body.has_method("activar_inmunidad"):
				body.activar_inmunidad(tiempo_inmunidad)
			if body.has_method("use_power_up"):
				body.use_power_up()
			posicionar_aleatoriamente()
			
		await get_tree().create_timer(tiempo_reaparicion).timeout
		sprite.show()
		await get_tree().process_frame
		collision.disabled = false
		coold = false
	else:
		print("cooldownlol")
 
