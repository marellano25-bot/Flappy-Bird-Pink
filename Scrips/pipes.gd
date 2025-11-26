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

# Colisión
func _on_pipe_top_body_entered(body: Node2D) -> void:
	if not (body is Bird):
		$golpexd.play()
		return

	if body.inmune:
		# Golpe visual/sonoro pero sin game over
		if body.has_node("hit_sound"):
			body.get_node("hit_sound").play()
		return
	if body is Bird:
		if body.has_node("chavo_sound"):
			body.get_node("chavo_sound").play()
		print("works on pipe top")
	
	_show_game_over()


# Colisión2
func _on_pipe_down_body_entered(body: Node2D) -> void:
	if not (body is Bird):
		return

	if body.inmune:
		if body.has_node("hit_sound"):
			body.get_node("hit_sound").play()
		return

	if body is Bird:
		if body.has_node("chavo_sound"):
			body.get_node("chavo_sound").play()
		print("works on pipe down")
	
	_show_game_over()

#La función que se encarga de la pantalla del game over
func _show_game_over() -> void:
	
	
	Global.game_over()

	var gaovinstance = gaovsc.instantiate()

	# Para obtener el nodo
	var control_child = gaovinstance.get_node("Control2") 
	control_child.process_mode = Node.PROCESS_MODE_ALWAYS

	get_tree().current_scene.add_child(gaovinstance)

	await get_tree().create_timer(0.5).timeout
	get_tree().paused = true


# Collision = points
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
