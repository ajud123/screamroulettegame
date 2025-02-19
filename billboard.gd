extends Label3D

var player: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("player", true, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transform = transform.looking_at(player.position, Vector3.UP, true)
	pass
