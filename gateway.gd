@tool
extends MeshInstance3D
#@export var gatewayName: String;
@export var pair: MeshInstance3D
@export var gamma: float = 1;
#@export var size: Vector2 = Vector2.ONE;

@export
var size: Vector2:
	get:
		return size
	set(value):
		print("setting size for " + name)
		size = value
		(mesh as QuadMesh).size = size
		if $teleporter/CollisionShape3D != null:
			var shape = (($teleporter/CollisionShape3D as CollisionShape3D).shape as BoxShape3D)
			shape.size.y = size.y
			shape.size.z = size.x
		
var camera: Camera3D
var can_teleport: bool = true
var teleporter: Area3D
var subviewport: SubViewport;
var cam_body: Node3D;
var player: Node3D;

func load_props() -> void:
	subviewport = $SubViewport
	camera = $SubViewport/anchor/body/Camera3D
	teleporter = $teleporter
	cam_body = $SubViewport/anchor/body

func PointToPlaneDistance(pointPosition: Vector3, planePosition: Vector3, planeNormal: Vector3):
	# more magic that doesnt work
	var sb: float;
	var sn: float;
	var sd: float;
	
	sn = -planeNormal.dot((pointPosition - planePosition))
	sd = planeNormal.dot(planeNormal);
	sb = sn/sd;
	var result = pointPosition + sb * planeNormal;
	return abs(pointPosition.distance_to(result));
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("player", true, false)
	load_props()
	pair.load_props()
	
	# initial shader settings so manual labour is reduced
	(self.material_override as ShaderMaterial).set_shader_parameter("texture_albedo", $SubViewport.get_texture())
	(self.material_override as ShaderMaterial).set_shader_parameter("gamma", gamma)
	
	# also adjust the portal plane size along with the teleport collider
	(mesh as QuadMesh).size = size
	var shape = (($teleporter/CollisionShape3D as CollisionShape3D).shape as BoxShape3D)
	shape.size.y = size.y
	shape.size.z = size.x
	
	#unsure if needed?
	$SubViewport/anchor.position = pair.teleporter.global_position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Engine.is_editor_hint() and pair:
		(self.material_override as ShaderMaterial).set_shader_parameter("gamma", gamma)
		var cam = EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
		
		$SubViewport/anchor.global_position = teleporter.global_position
		$SubViewport/anchor.global_rotation = global_rotation
		
		cam_body.global_position = cam.global_position
		camera.global_rotation = cam.global_rotation
		
		$SubViewport/anchor.position = pair.teleporter.global_position
		$SubViewport/anchor.global_rotation = pair.teleporter.global_rotation
		
	elif not Engine.is_editor_hint():
		# the general gist is that we recreate the positions where the player
		# is relative to the portal that the player looks at
		$SubViewport/anchor.global_position = teleporter.global_position
		$SubViewport/anchor.global_rotation = global_rotation
		
		cam_body.global_position = player.global_position
		camera.global_rotation = player.camera.global_rotation
		
		# once the recreation is done, we can set the anchor's position
		# to where the destination portal(teleporter) is and also apply the respective rotation
		# ideally the anchor should be rotated 180 degrees so we're looking through the destination portal
		# so we in editor rotate the teleporter 180 degrees and just use it's rotation
		# by doing so the game automatically rotates the cameras and all because they're all children
		$SubViewport/anchor.position = pair.teleporter.global_position
		$SubViewport/anchor.global_rotation = pair.teleporter.global_rotation
		
		pass
		
	var dist = ($SubViewport/anchor/body/Camera3D.global_position as Vector3).distance_to(pair.global_position)
	#$SubViewport/anchor/body/Camera3D.near = clampf(($SubViewport/anchor/body/Camera3D.global_position as Vector3).distance_to(pair.global_position), 0.005, 1000)
	$SubViewport/anchor/body/Camera3D.near = clampf(dist, 0.005, 1000)
	#print(name + " " + str(dist))
	
	#$SubViewport/anchor.rotation_degrees.y = rotation_degrees.y
	#$SubViewport/Camera3D.rotation_degrees.z += 180
	pass

func _on_teleporter_body_entered(body: Node3D) -> void:
	if can_teleport:
		print("---")
		print(body.global_position)
		print(cam_body.global_position)
		print(body.name + " teleporting from " + name + " to " + pair.name)
		# simple enough, we just swap whoever touches the thing with the camera body
		body.global_position = cam_body.global_position
		body.global_rotation.y = camera.global_rotation.y
		print(body.global_position)
		print(cam_body.global_position)
		# also since we will basically appear in the destination portal's teleport collider,
		# we set it so that it doesnt teleport for that one time so we dont just get thrown back
		# and fourth
		pair.can_teleport = false
		print()
		print("---")
	else:
		print("teleport blocked for " + name)
		can_teleport = true
	pass # Replace with function body.
