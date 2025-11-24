extends Control
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

func _ready():
	print("Works")
	audio_stream_player.play()
	
func _input(_event): 
	if Input.is_action_just_pressed("Accept"):
		Global.score = 0
		Global.actscore = false
		get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	
func _on_quitbtn_pressed() -> void:
	get_tree().quit()
	
