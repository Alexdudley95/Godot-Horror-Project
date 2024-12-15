extends Node3D

var playerInArea = false
var consumed = false
var highlight_mat = preload("res://textures/batteries_glow.png")
var mat = preload("res://textures/batteries.png")

#func _on_area_3d_body_entered(body: Node3D) -> void:
		#if body.is_in_group("Player"):
			#$".".queue_free()

func _process(delta: float) -> void:
	if playerInArea && Input.is_action_just_pressed("interact"):
		consumed = true
		$".".hide()


func _on_area_3d_has_been_hit() -> void:
	if !consumed:
		$Sprite3D.texture = highlight_mat
		$Sprite3D.shaded = false
		print_debug("Bat Hit")
		playerInArea = true
		$"../../player".text = "Batteries"
		$"../../player".displayText()
	pass # Replace with function body.


func _on_area_3d_not_hit() -> void:
	$Sprite3D.shaded = true
	$Sprite3D.texture = mat
	playerInArea = false
	pass # Replace with function body.
