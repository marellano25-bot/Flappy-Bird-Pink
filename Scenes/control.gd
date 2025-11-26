extends Control
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"
var puede_reiniciar := false

func _ready():
	await get_tree().create_timer(2.0).timeout
	puede_reiniciar = true
	print("Espera 2 seg. para Restart")
	audio_stream_player.play()
	
func _input(_event): 
	if not puede_reiniciar:
		return  # 👈 todavía no puede reiniciar
		
	if Input.is_action_just_pressed("Accept"):
		print("RESTART")
		Global.score = 0
		Global.actscore = false
		get_tree().change_scene_to_file("res://cosoprincipal.tscn")
	
func _on_quitbtn_pressed() -> void:
	get_tree().quit()
	
