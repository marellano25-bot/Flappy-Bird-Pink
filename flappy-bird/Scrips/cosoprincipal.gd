extends Node

@export var pipes_scene:PackedScene

func _ready() -> void:
	$Timerpipe.start()

func create_pipe():
	var pipes = pipes_scene.instantiate()
	add_child(pipes)
	
func _on_timerpipe_timeout() -> void:
	create_pipe()
	 
