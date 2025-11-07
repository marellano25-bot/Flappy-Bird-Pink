extends Control

func _ready():
	print("GameOver UI loaded!")
	
func _on_reloadbtn_pressed() -> void:
	get_tree().paused = false
	#await get_tree().process_frame
	get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	#await get_tree().process_frame
	#Global.game_start()
	
func _on_quitbtn_pressed() -> void:
	print("Quit pressed!")  # test
	get_tree().quit()
	
func start_game():
	$Startbtn.hide()
	$Puntero.hide()
