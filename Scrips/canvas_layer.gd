extends CanvasLayer

var numeros := []

func _ready() -> void:
	Global.connect("on_Increment_score", change_score)
	Global.connect("on_game_start", _on_game_start)
	Global.count = self
	#para los números
	for i in range(10):
		var coso = load("res://art/%d.png" % i)
		numeros.append(coso)
		#vector2, es decir que son dos valores juntos, como tamaño,escala, posicion, etc
		$num_1.scale = Vector2(0.09, 0.09)
		$num_2.scale = Vector2(0.09, 0.09)
	
	$num_1.hide()
	$num_2.hide()

func actualizar_numeros(score: int) -> void:
	var texto := str(score)
	
	if texto.length() == 1:
		$num_1.hide()
		$num_2.show()
		$num_2.position.x = 148 #Agregué esto para que siempre esté centrado, pero falta modificar los assets.
		$num_2.texture = numeros[int(texto[0])]
		
	elif texto.length() == 2:
		$num_1.show()
		$num_1.position.x = 120
		$num_2.show()
		$num_2.position.x = 176
		$num_1.texture = numeros[int(texto[0])]
		$num_2.texture = numeros[int(texto[1])]
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if Global.is_start == false:
			Global.game_start()
			start_game()

func _process(delta: float) -> void:
	#$LabelScore.text = str(Global.score)
	pass
func change_score():
	actualizar_numeros(Global.score)
	if not Global.actscore:
		$num_2.show()
		Global.actscore = true
		
func _on_game_start() -> void:
	start_game()               
	actualizar_numeros(Global.score)

func start_game():
	$Startbtn.hide()
	$Puntero.hide()
	#Para reiniciar todo (o más bien, que no se mire)
	$num_2.hide()
	Global.score = 0
	Global.actscore = false
	
	actualizar_numeros(Global.score)
	
	
