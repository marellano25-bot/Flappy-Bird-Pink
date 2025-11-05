extends Node2D

@export var velocidad := 300.0
@export var reset_x := 320.0
@export var min_y := 133.0
@export var max_y := 300.0

var punto_agregado := false

func _ready() -> void:
	randomize()
	position.x = reset_x
	position.y = randi_range(min_y, max_y)

func _process(delta: float) -> void:
	position.x -= velocidad * delta

	# Cuando salen de pantalla, reubícalos y permite volver a sumar punto
	if position.x < -400.0:
		position.x = reset_x
		position.y = randi_range(min_y, max_y)
		punto_agregado = false


# --- COLISIÓN CON EL TUBO SUPERIOR ---
func _on_pipe_top_body_entered(body: Node2D) -> void:
	if not (body is Bird):
		return

	if body.inmune:
		# Golpe visual/sonoro pero sin game over
		if body.has_node("hit_sound"):
			body.get_node("hit_sound").play()
		return

	if body.has_node("die_sound"):
		body.get_node("die_sound").play()
	Global.game_over()  # puedes pasar tag: Global.game_over("pipe_top")


# --- COLISIÓN CON EL TUBO INFERIOR ---
func _on_pipe_down_body_entered(body: Node2D) -> void:
	if not (body is Bird):
		return

	if body.inmune:
		if body.has_node("hit_sound"):
			body.get_node("hit_sound").play()
		return

	if body.has_node("die_sound"):
		body.get_node("die_sound").play()
	Global.game_over()  # puedes pasar tag: Global.game_over("pipe_down")



# --- ÁREA PARA SUMAR PUNTO ---
func _on_area_2d_add_punto_body_entered(body: Node2D) -> void:
	if not (body is Bird):
		return
	if punto_agregado:
		return

	punto_agregado = true
	Global.Increment_score()

	if body.has_node("point_sound"):
		body.get_node("point_sound").play()

	print("puntaje actual:", Global.score)
