extends Interaction

@export var parentNode: Node
@export var SpawnScenes: Array[SpawnedScene];

func interactWith() -> void:
	for spawnScene in SpawnScenes:
		var inst = spawnScene.Scene.instantiate()
		parentNode.add_child(inst);
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
