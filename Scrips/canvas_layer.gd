extends CanvasLayer

func _ready() -> void:
	Global.connect("on_Increment_score", change_score)
	Global.connect("on_game_start", _on_game_start)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if Global.is_start == false:
			Global.game_start()
			start_game()

func _process(delta: float) -> void:
	#$LabelScore.text = str(Global.score)
	pass
func change_score():
	$LabelScore.text = str(Global.score)
	
	
func _on_game_start() -> void:
	start_game()
	
func start_game():
	$Startbtn.hide()
	$Puntero.hide()
