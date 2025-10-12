extends CharacterBody2D

@export var gravity := 1000.0
@export var jump_force := 300.0

func _ready() -> void:
	# Asegurar que Space esté mapeado a "ui_accept" (por código)
	if not InputMap.has_action("ui_accept"):
		InputMap.add_action("ui_accept")
	var ev := InputEventKey.new()
	ev.physical_keycode = KEY_SPACE
	InputMap.action_add_event("ui_accept", ev)
	print("Listo: Space -> ui_accept (CharacterBody2D)")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_force
	move_and_slide()
