extends CanvasLayer

func _on_reloadbtn_pressed() -> void:
	if Input.is_action_pressed("Accept"):
		Global.score = 0
		Global.actscore = false
		get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	

func _on_quitbtn_pressed() -> void:
	get_tree().quit()
