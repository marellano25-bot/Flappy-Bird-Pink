extends CanvasLayer

func _on_reloadbtn_pressed() -> void:
	get_tree().change_scene_to_file("res://cosoprincipal.tscn")


func _on_quitbtn_pressed() -> void:
	get_tree().quit()
