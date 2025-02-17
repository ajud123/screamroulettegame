extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var camera: Camera3D
var maxHealth = 100;
var health: float:
	get:
		return health;
	set(value):
		health = clampf(value, 0, maxHealth);
		
var vignette: ColorRect

func _ready() -> void:
	health = 100;
	camera = $Camera3D
	vignette = %fx.get_node("vignette")
	

func _process(delta: float) -> void:
	(vignette.material as ShaderMaterial).set_shader_parameter("outerRadius", health/maxHealth * 5);
	(vignette.material as ShaderMaterial).set_shader_parameter("MainAlpha", (1-(health/maxHealth)) * 0.5);
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("l", "r", "fwd", "bck")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
