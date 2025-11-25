extends Node
@onready var point_sound = $point_sound

signal on_Increment_score
signal on_game_start

var score := 0
var is_start := false
var actscore := false
var first_run := true
var count

func game_start():
	is_start = true
	first_run = false
	emit_signal("on_game_start")
	score = 0
func reset_game_state():
	is_start = false
	
func Increment_score():
	score += 1
	emit_signal("on_Increment_score")
	
	
func game_over(_tag: String = ""):
	get_tree().paused = true
	# acá el juego va a quedar pausado
