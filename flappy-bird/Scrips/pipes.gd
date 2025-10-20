extends Node2D

@export var velocidad := 300
var punto_agregado := false

func _ready():
	position.x = 320
	position.y = randi_range(133, 300)


func _process(delta):
	position.x -= velocidad * delta
	
	#if position.x < -400:
		#queue_free()


# COLISIÓN CON EL TUBO INFERIOR
func _on_pipe_down_body_entered(body: Node2D) -> void:
	if body == null:
		return
	
	if body.name == "Bird":
		# Ignorar colisión si está inmune
		if "inmune" in body and body.inmune:
			print("Bird chocó el tubo de abajo pero está inmune, no muere.")
			if body.has_node("hit_sound"):
				body.get_node("hit_sound").play()  # reproducir sonido de golpe desde el pájaro
			return

		# Si no tiene inmunidad, muere
		print("Bird chocó el tubo de abajo y murió.")
		if body.has_node("die_sound"):
			body.get_node("die_sound").play()  # reproducir sonido de muerte
		if body.has_method("game_over"):
			body.game_over()


# COLISIÓN CON EL TUBO SUPERIOR
func _on_pipe_top_body_entered(body: Node2D) -> void:
	if body == null:
		return
	
	if body.name == "Bird":
		if "inmune" in body and body.inmune:
			print("Bird chocó el tubo de arriba pero está inmune, no muere.")
			if body.has_node("hit_sound"):
				body.get_node("hit_sound").play()
			return

		print("Bird chocó el tubo de arriba y murió.")
		if body.has_node("die_sound"):
			body.get_node("die_sound").play()
		if body.has_method("game_over"):
			body.game_over()


# DETECCIÓN DE PUNTO
func _on_bird_passed_pipe(body: Node2D) -> void:
	if body.name == "Bird" and not punto_agregado:
		punto_agregado = true
		if body.has_method("sumar_punto"):
			body.sumar_punto()
		if body.has_node("point_sound"):
			body.get_node("point_sound").play()  # reproducir sonido de punto
