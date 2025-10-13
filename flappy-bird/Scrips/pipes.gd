extends Node2D
class_name Bird

var velocity = 300
func _ready() -> void:
	position.x = 320
	position.y = randi_range(133,300)

func _process(delta: float) -> void:
	position.x -=delta * velocity
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	


func _on_pipe_down_body_entered(body: Node2D) -> void:
	if body is Bird:
		print("Choco el pajarito")
		
	


func _on_pipe_top_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
