extends CharacterBody2D
class_name Bird

@export var gravity := 1000.0
@export var jump_force := 300.0

@onready var anim = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D 

@onready var wing_sound = $wing_sound
@onready var swoosh_sound = $swoosh_sound
@onready var point_sound = $point_sound

@onready var die_sound = $die_sound
@onready var hit_sound = $hit_sound
# @onready var chavo_sound = $chavo_sound
@onready var chavo_sound: AudioStreamPlayer2D = $chavo_sound
#(Sirve el chavo_sonido!!)

var inmune: bool = false
const PIPE_LAYER := 2 #capa en la que se encuentran las pipes

func _ready() -> void:
	if has_node("chavo_sound"):
		var cs = get_node("chavo_sound")
		cs.playing = false
		cs.autoplay = false
		cs.stream_paused = false
		cs.volume_db = 0.0
	print("Script de Bird cargado correctamente")
	

func _physics_process(delta: float) -> void:
	if Global.is_start:
		velocity.x = 0
		velocity.y += gravity * delta

		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force
		move_and_slide()

		var collision_info = get_last_slide_collision()
		if collision_info and not inmune:
			var collider = collision_info.get_collider()
			if collider.is_in_group("pipes"):
				print("Bird chocó")
				if position.y > 600 or position.x < -200:
					get_tree().quit()
				if Input.is_action_just_pressed("ui_accept"):
					velocity.y = -jump_force
					wing_sound.play()


# holam, esta es la parte visual

func use_power_up():
	var powerUpDuration = 5
	var anim_actual = anim.animation
	anim.play("Rodrigo")
	await get_tree().create_timer(powerUpDuration).timeout
	anim.play(anim_actual)
	collision.disabled = false

# this is the parte lógica

func activar_inmunidad(tiempo: float) -> void:
	inmune = true
	var original_mask = collision_mask

	set_collision_mask_value(PIPE_LAYER, false)
	await get_tree().create_timer(tiempo).timeout

	collision_mask = original_mask
	inmune = false
