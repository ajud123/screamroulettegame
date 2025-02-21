extends Camera3D
@export var sensitivity: float = 0.1;
var parent: Node3D;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent();
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse = event as InputEventMouseMotion
		parent.rotation_degrees.y += mouse.relative.x * -sensitivity;
		rotation_degrees.x = clampf(rotation_degrees.x + (mouse.relative.y * -sensitivity), -90, 90);
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED) and event is InputEventMouseButton: 
		print("should capture mouse")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
	pass
