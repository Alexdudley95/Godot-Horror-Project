extends Area3D

var currentlyHit = false
signal hasBeenHit
signal notHit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func hit() -> void:
	currentlyHit = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentlyHit == true:
		print_debug("HIT")
		hasBeenHit.emit()
	else:
		notHit.emit()
	
	currentlyHit = false
	
	pass
