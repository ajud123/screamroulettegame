@tool
extends MeshInstance3D
@export var scaling: float = 1;
@export var offset: Vector3;
@export var changeInterval: float = 10;
@export var damageMult = 1;
@export var gregDimensions: Vector2;
@export_range(0, 1, 0.05) var changeThreshold: float;
@export var runInEditor: bool = false;
var elapsed: float = 0;
var rng = RandomNumberGenerator.new()

var targetPower: float = 0;

var player: Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("player", true, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint(): # editor magic so we can adjust greg in editor
		if runInEditor:
			transform = transform.looking_at(player.position)
			(mesh as QuadMesh).size = gregDimensions * scaling;
			offset = global_position - player.global_position;
	else:
		global_position = %player.global_position + offset;
		transform = transform.looking_at(player.position)
		# the principle of it all is that every changeInterval seconds(?) 
		# the game generates a random value and then checks if its above the threshold
		# if it is, we turn on the lights and greg will watch for u
		elapsed += delta*1;
		if elapsed > changeInterval:
			print("duration achieved")
			var val = rng.randf_range(0, 1);
			elapsed = 0
			if val > changeThreshold:
				print("the sun activates")
				(material_override as ShaderMaterial).set_shader_parameter("eyeClosed", false);
				targetPower = 2
			else:
				print("the sun deactivates")
				(material_override as ShaderMaterial).set_shader_parameter("eyeClosed", true);
				targetPower = 0
		# we define a target power value so we can smoothly interpolate and it isnt as jarring
		$"the sun".light_energy = lerpf($"the sun".light_energy, targetPower, delta)
		if targetPower == 2:
			# literal magic
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(player.global_position, global_position)
			var result = space_state.intersect_ray(query)
			if !result:
				# simple enough, just taking away health by the time elapsed and a multiplier so we can adjust it
				player.health -= delta * damageMult;
				#print("I CAN SEE YOU")
			pass
		pass
	pass
