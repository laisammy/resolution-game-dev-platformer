extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -400.0

@onready var timer: Timer = $timer
@onready var sprite_2d: Sprite2D = $sprite2d

func _process(delta: float) -> void:
	timeLeft()
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func boost_jump():
	JUMP_VELOCITY = JUMP_VELOCITY * 1.5  # extra jump power
	print("success!", JUMP_VELOCITY)
	timer.start()
	
func timeLeft() -> void:
	var timeLeft = timer.time_left
	SignalHub.emit_timeLeft(timeLeft)

func _on_timer_timeout() -> void:
	JUMP_VELOCITY = -400.0
	SignalHub.emit_fetchNextWord()
