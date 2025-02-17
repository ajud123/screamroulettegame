extends SubViewportContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewport.size = Vector2i(1920*2, 1080*2) #DisplayServer.screen_get_size()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var size = get_viewport_rect().size as Vector2i
	var sv = $SubViewport
	if sv.size != size:
		sv.size = size
		print("Viewport size: " + str(size))
		
	pass
