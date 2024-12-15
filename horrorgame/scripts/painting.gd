extends Node3D
@onready var sprite = $Sprite3D
var painting_1_alt = preload("res://textures/paintings/painting_1_alt.png")
var painting_1 = preload("res://textures/paintings/painting_1.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.set_texture(painting_1_alt)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
