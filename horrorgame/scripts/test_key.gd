extends Area3D

@export var key_group = ""
@export var label_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Label.text = label_text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.add_to_group(key_group)
		print_debug(body.get_groups())
		$Label.show()
		$Timer.start()
		$Sprite3D.hide()
		$CollisionShape3D.hide()

func _on_timer_timeout() -> void:
	$".".queue_free()
