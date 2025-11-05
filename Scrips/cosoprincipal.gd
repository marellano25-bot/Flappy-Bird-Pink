extends Node

@export var pipes_scene:PackedScene

func _ready() -> void:
	Global.connect("on_game_start", game_start)
	$Timerpipe.stop()
	
func game_start():
	$Timerpipe.start()

func create_pipe():
	var pipes = pipes_scene.instantiate()
	add_child(pipes)
	
func _on_timerpipe_timeout() -> void:
	create_pipe()

func _on_area_2d_floor_body_entered(body: Node2D) -> void:
	if body is Bird:
		Global.game_over()
		$Timerpipe.stop()
