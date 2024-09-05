extends CharacterBody3D

const SPEED = 3.9
const JUMP_VELOCITY = 3.75
const MOUSE_SENSITIVITY = 0.15

@onready var camera = $Head/Camera  # Reference to the Camera node

var mouse_look = Vector2()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED  # Capture mouse for FPS style

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_look.x -= event.relative.x * MOUSE_SENSITIVITY
		mouse_look.y = clamp(mouse_look.y - event.relative.y * MOUSE_SENSITIVITY, -89, 89)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("Left", "Right", "Forwards", "Backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Apply movement
	move_and_slide()

	# Update camera rotation based on mouse look
	rotation_degrees.y = mouse_look.x
	rotation_degrees.x = mouse_look.y
