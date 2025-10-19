extends Node2D

var velocity := 300

func _ready() -> void:
	position.x = 320
	position.y = randi_range(133, 300)

func _process(delta: float) -> void:
	position.x -= delta * velocity

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


# COLISIÓN CON EL TUBO INFERIOR
func _on_pipe_down_body_entered(body: Node2D) -> void:
	# Para saber si el objeto tiene un script y existe
	if body == null:
		return
	if not body.has_method("activar_inmunidad"):
		return

	if body.name == "Bird":
		# Si tiene inmunidad, ignoramos la colisión
		if "inmune" in body and body.inmune:
			return

		#Para cuando exista el método
		#if body.has_method("game_over"):
		#	body.game_over()


# COLISIÓN CON EL TUBO SUPERIOR

func _on_pipe_top_body_entered(body: Node2D) -> void:
	if body == null:
		return
	if not body.has_method("activar_inmunidad"):
		return

	if body.name == "Bird":
		if "inmune" in body and body.inmune:
			return

#		if body.has_method("game_over"):
#			body.game_over()
