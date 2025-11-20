extends Control

func _ready():
	print("Works")
	
func _input(_event): 
	if Input.is_action_just_pressed("Accept"):
		get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	#await get_tree().process_frame
	#Global.game_start()
	
func _on_quitbtn_pressed() -> void:
	get_tree().quit()
	
func start_game():
	$Startbtn.hide()
	$Puntero.hide()
