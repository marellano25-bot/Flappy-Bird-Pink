extends Node2D

@export var velocidad := 300.0
@export var min_y := 133.0
@export var max_y := 300.0
var gaovsc = preload("res://Scenes/GameOver.tscn")
var punto_agregado := false

func _ready() -> void:
	randomize()
	position.y = randi_range(min_y, max_y)
func _process(delta: float) -> void:
	position.x -= velocidad * delta

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
		_show_game_over()


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
		_show_game_over()
		

func _show_game_over() -> void:
	Global.game_over()

	var gaovinstance = gaovsc.instantiate()

	# get the Control node inside the GameOver scene
	var control_child = gaovinstance.get_node("Control2")  # change name if needed
	control_child.process_mode = Node.PROCESS_MODE_ALWAYS

	get_tree().current_scene.add_child(gaovinstance)

	await get_tree().process_frame
	get_tree().paused = true

		



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
