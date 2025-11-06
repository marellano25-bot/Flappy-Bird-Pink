extends Control

func _ready():
	print("GameOver UI loaded!")
	
func _on_reloadbtn_pressed() -> void:
	print("Reload pressed!")  # test
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	
func _on_quitbtn_pressed() -> void:
	print("Quit pressed!")  # test
	get_tree().quit()
	
	  # just to test visibility
