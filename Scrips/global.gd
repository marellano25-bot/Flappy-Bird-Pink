extends Node
@onready var point_sound = $point_sound
#@onready var chavo_sound: AudioStreamPlayer2D = $chavo_sound

signal on_Increment_score
signal on_game_start

var grav = true
var score := 0
var is_start := false
var actscore := false
var first_run := true
var count
var yabasta = false
var jump = true

func game_start():
	is_start = true
	first_run = false
	emit_signal("on_game_start")
	score = 0
func reset_game_state():
	is_start = false
	
func bastaaa():
	yabasta = true
	print("Si funciona el bastaaa")
	
func Increment_score():
	score += 1
	emit_signal("on_Increment_score")
	
	

#func game_over(_tag: String =  ""):
	#print("...")
func game_over(_tag: String = ""):
	#chavo_sound.play()
	#Global.grav = false
	Global.jump = false
	await get_tree().create_timer(0.5).timeout
#(Sirve el chavo_sonido!!)
	get_tree().paused = true
	# acá el juego va a quedar pausado
