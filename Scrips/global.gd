extends Node

signal on_Increment_score

var score := 0
var is_start := false

# func game_start():
	# is_start = true
	
func Increment_score():
	score += 1
	emit_signal("on_Increment_score")
	
func game_over(tag: String = ""):
	print("GAME OVER ", tag)
	get_tree().paused = true
	# acá el juego va a quedar pausado
