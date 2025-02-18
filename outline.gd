class_name InteractableObject
extends Node3D
@export var outline: MeshInstance3D;
@export var baseObject: Node3D;

func enable_glow() -> void:
	outline.show()

func disable_glow() -> void:
	outline.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
