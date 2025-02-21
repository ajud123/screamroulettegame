extends MeshInstance3D

var player: Node3D
var positions: Array[Vector3] = []
@export var shouldFollow: bool = false
@export var damageMult =  1;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("player", true, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in enteredBodies:
		if body is PlayerObject:
			body.health -= delta * damageMult;
	pass
	
func _physics_process(delta: float) -> void:
	positions.push_back(player.global_position);
	if shouldFollow:
		var newPos = positions.pop_front()
		global_position = newPos;
		if player.position.distance_squared_to(position) > 2:
			transform = transform.looking_at(player.position)
	pass

var enteredBodies = []

func _on_timer_timeout() -> void:
	shouldFollow = true;
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body.name  + " entered")
	enteredBodies.append(body)
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	enteredBodies.remove_at(enteredBodies.find(body))
	print(body.name  + " left")
	pass # Replace with function body.
