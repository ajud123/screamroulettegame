extends Interaction

@export var DestroyNodes: Array[Node3D];
@export var DisableNodes: Array[Node3D];
@export var EnableNodes: Array[Node3D];
@export var DestroySelf: bool;

func interactWith() -> void:
	for node in DestroyNodes:
		node.queue_free() 
	for node in DisableNodes:
		node.hide()
	for node in EnableNodes:
		node.show()
	if DestroySelf:
		get_parent().queue_free()
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
