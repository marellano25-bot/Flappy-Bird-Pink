extends Node
@onready var chavo_sound: AudioStreamPlayer2D = $chavo_sound
@export var pipes_scene:PackedScene
@export var min_pipe_distance := 250.0
@export var spawn_x_start := 300
@onready var point_sound = $point_sound
var last_pipe_x := 0.0
var gameover = preload("res://Scenes/GameOver.tscn")

func _ready() -> void:
	$chavo_sound.stream_paused = false
	get_tree().paused = false
	Global.connect("on_game_start", game_start)
	$Timerpipe.stop()
	#Checa que si es el primer intento
	if not Global.first_run:
		await get_tree().process_frame
		Global.game_start()
	
func game_start():
	$Timerpipe.start()

func create_pipe():
	var pipes = pipes_scene.instantiate()
	add_child(pipes)
	if last_pipe_x == 0.0:
		pipes.position.x = spawn_x_start
	else:
		pipes.position.x = last_pipe_x + min_pipe_distance
	pipes.position.y = randi_range(133, 300)
	
func _on_timerpipe_timeout() -> void:
	create_pipe()


func _on_area_2d_floor_body_entered(body: Node2D) -> void:
	if body is Bird:
		Global.game_over()
		$Timerpipe.stop()

		# Llama a gameover
		var gameover_scene = preload("res://Scenes/GameOver.tscn")
		var gameover_instance = gameover_scene.instantiate()
		var control_child = gameover_instance.get_node("Control2") #Obtener el nodo
		
		control_child.process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().current_scene.add_child(gameover_instance)

		# Para que el menu cargue adecuadamente, espera un cuadro
		await get_tree().process_frame
		get_tree().paused = true
