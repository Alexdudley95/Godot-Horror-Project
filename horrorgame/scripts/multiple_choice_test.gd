extends Node3D

var mouse = InputEventMouseMotion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		$Label.show()
		if Input.is_action_just_pressed("interact"):
			$Label.hide()
			




func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
